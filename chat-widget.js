(function(){
'use strict';

/* ── API Key Anthropic — inserisci qui la tua key ── */
const ANTHROPIC_API_KEY = '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';

const SYSTEM_PROMPT = `Sei l'assistente riservato dello studio legale dell'Avv. Niccolò Vecchioni, penalista a Milano con 18+ anni di esperienza. Studio NC Law, Via Cerva 6, Milano.

Aree di competenza dello studio:
- Reati contro la persona (lesioni, risse, sequestro di persona, tentato omicidio)
- Rapine e reati predatori
- Stupefacenti
- Reati legati alla street life e ai giovani (resistenza a pubblico ufficiale, porto abusivo d'arma, reati di gruppo)
- Circolazione stradale e guida in stato di ebbrezza

NON dire MAI che lo studio si occupa di:
- Criminalità organizzata / 416 bis / mafia
- Penale d'impresa / reati societari
- Diffamazione / reati online
- Sicurezza sul lavoro

Se ti chiedono di queste aree, rispondi onestamente: "Lo studio Vecchioni è specializzato in difesa penale di strada e reati contro la persona. Per la sua richiesta le consiglio di cercare uno studio specializzato in quel settore specifico. Posso comunque raccogliere i suoi dati e l'avvocato valuterà personalmente."

Come ti comporti:
- Rispondi in modo professionale, empatico, rassicurante
- Massimo 2-3 frasi per risposta
- SOLO italiano
- NON dai pareri legali specifici, NON prometti risultati
- Quando raccogli nome + telefono + descrizione, mostra riepilogo e chiedi conferma
- Riservatezza assoluta — segreto professionale
- Prima consulenza: contatto senza impegno, costi discussi dopo valutazione caso
- Disponibilità: risposta entro 24 ore, urgenze h24
- Email: niccolo.vecchioni@nclaw.it

Tono: empatico, calmo, protettivo, senza pressione. Non fare mai urgenza artificiale. Ascolta prima di proporre. Se la persona vuole solo informazioni, dalle senza forzare la raccolta dati.`;

const WELCOME = 'Buongiorno, sono l\'assistente riservato dell\'Avv. Vecchioni. Come posso aiutarla?';
const QUICK_REPLIES = [
  'Ho bisogno di un avvocato penalista',
  'Vorrei informazioni sulle aree di competenza',
  'Come funziona il primo contatto?'
];

/* ── EmailJS config (same as site) ── */
const EJS_SERVICE  = 'service_axen7bv';
const EJS_TEMPLATE = 'template_i41j5j8';
const EJS_KEY      = '09DDAzcm8wfSR0ANQ';

/* ── State ── */
let isOpen = false;
let messages = []; // conversation history sent to API
let isTyping = false;
let fallbackMode = false;

/* ── Session persistence ── */
function saveSession(){ try{ sessionStorage.setItem('nv_chat', JSON.stringify(messages)); }catch(e){} }
function loadSession(){ try{ const d=sessionStorage.getItem('nv_chat'); if(d){ messages=JSON.parse(d); return true; } }catch(e){} return false; }

/* ── Inject CSS ── */
const style = document.createElement('style');
style.textContent = `
#nv-chat-fab{position:fixed;bottom:28px;right:28px;width:60px;height:60px;border-radius:50%;background:#0A0A0A;border:1px solid #C9A84C;cursor:pointer;z-index:99999;display:flex;align-items:center;justify-content:center;box-shadow:0 4px 24px rgba(0,0,0,.5);transition:transform .25s ease,box-shadow .25s ease}
#nv-chat-fab:hover{transform:scale(1.07);box-shadow:0 6px 32px rgba(201,168,76,.25)}
#nv-chat-fab svg{transition:transform .3s ease}
#nv-chat-fab.open svg{transform:rotate(90deg)}
#nv-chat-badge{position:absolute;top:-4px;left:-8px;background:#C9A84C;color:#0A0A0A;font-family:Inter,sans-serif;font-size:11px;font-weight:600;padding:4px 10px;border-radius:12px;white-space:nowrap;opacity:0;transform:translateY(4px);transition:opacity .4s ease,transform .4s ease;pointer-events:none}
#nv-chat-badge.show{opacity:1;transform:translateY(0)}

#nv-chat-win{position:fixed;bottom:100px;right:28px;width:380px;max-height:560px;background:#141414;border:1px solid #2A2A2A;border-radius:16px;z-index:99998;display:flex;flex-direction:column;overflow:hidden;opacity:0;transform:translateY(16px) scale(.96);pointer-events:none;transition:opacity .3s ease,transform .3s ease;box-shadow:0 12px 48px rgba(0,0,0,.6)}
#nv-chat-win.open{opacity:1;transform:translateY(0) scale(1);pointer-events:all}

.nv-ch-header{display:flex;align-items:center;justify-content:space-between;padding:16px 20px;border-bottom:1px solid #2A2A2A;background:#111}
.nv-ch-header-info{display:flex;align-items:center;gap:12px}
.nv-ch-header-dot{width:10px;height:10px;border-radius:50%;background:#4CAF50;flex-shrink:0}
.nv-ch-header-text h4{margin:0;font-family:Inter,sans-serif;font-size:14px;font-weight:700;color:#fff;line-height:1.3}
.nv-ch-header-text span{font-family:Inter,sans-serif;font-size:11px;color:#888;font-weight:400}
.nv-ch-close{background:none;border:none;color:#666;cursor:pointer;padding:4px;transition:color .2s}
.nv-ch-close:hover{color:#fff}

.nv-ch-body{flex:1;overflow-y:auto;padding:16px 16px 8px;display:flex;flex-direction:column;gap:10px;min-height:280px;max-height:380px;scrollbar-width:thin;scrollbar-color:#333 transparent}
.nv-ch-body::-webkit-scrollbar{width:5px}
.nv-ch-body::-webkit-scrollbar-track{background:transparent}
.nv-ch-body::-webkit-scrollbar-thumb{background:#333;border-radius:4px}

.nv-msg{max-width:85%;padding:10px 14px;border-radius:12px;font-family:Inter,sans-serif;font-size:13px;line-height:1.55;word-wrap:break-word;animation:nvMsgIn .3s ease}
.nv-msg.assistant{align-self:flex-start;background:#1E1E1E;color:#ddd;border-bottom-left-radius:4px}
.nv-msg.user{align-self:flex-end;background:rgba(201,168,76,.15);color:#fff;border-bottom-right-radius:4px}

@keyframes nvMsgIn{from{opacity:0;transform:translateY(6px)}to{opacity:1;transform:translateY(0)}}

.nv-qr-wrap{display:flex;flex-direction:column;gap:6px;margin-top:4px}
.nv-qr{background:transparent;border:1px solid rgba(201,168,76,.35);color:#C9A84C;font-family:Inter,sans-serif;font-size:12px;padding:8px 14px;border-radius:10px;cursor:pointer;text-align:left;transition:background .2s,border-color .2s}
.nv-qr:hover{background:rgba(201,168,76,.1);border-color:#C9A84C}

.nv-typing{align-self:flex-start;display:flex;gap:4px;padding:10px 16px;background:#1E1E1E;border-radius:12px;border-bottom-left-radius:4px}
.nv-typing span{width:6px;height:6px;background:#666;border-radius:50%;animation:nvDot 1.2s infinite}
.nv-typing span:nth-child(2){animation-delay:.2s}
.nv-typing span:nth-child(3){animation-delay:.4s}
@keyframes nvDot{0%,80%,100%{opacity:.3;transform:scale(.8)}40%{opacity:1;transform:scale(1)}}

.nv-ch-input{display:flex;align-items:center;gap:8px;padding:12px 16px;border-top:1px solid #2A2A2A;background:#111}
.nv-ch-input textarea{flex:1;background:#1A1A1A;border:1px solid #333;border-radius:10px;padding:10px 14px;color:#fff;font-family:Inter,sans-serif;font-size:13px;resize:none;outline:none;max-height:80px;line-height:1.4;transition:border-color .2s}
.nv-ch-input textarea:focus{border-color:rgba(201,168,76,.5)}
.nv-ch-input textarea::placeholder{color:#555}
.nv-ch-send{background:#C9A84C;border:none;border-radius:50%;width:36px;height:36px;display:flex;align-items:center;justify-content:center;cursor:pointer;flex-shrink:0;transition:background .2s,transform .15s}
.nv-ch-send:hover{background:#D4AF37}
.nv-ch-send:active{transform:scale(.92)}
.nv-ch-send:disabled{opacity:.4;cursor:default;transform:none}

/* Fallback inline form */
.nv-fb-form{display:flex;flex-direction:column;gap:8px;padding:12px;background:#1A1A1A;border:1px solid #2A2A2A;border-radius:12px;animation:nvMsgIn .3s ease}
.nv-fb-form input,.nv-fb-form textarea{background:#111;border:1px solid #333;border-radius:8px;padding:9px 12px;color:#fff;font-family:Inter,sans-serif;font-size:12px;outline:none;transition:border-color .2s}
.nv-fb-form input:focus,.nv-fb-form textarea:focus{border-color:rgba(201,168,76,.5)}
.nv-fb-form input::placeholder,.nv-fb-form textarea::placeholder{color:#555}
.nv-fb-form textarea{resize:none;min-height:50px}
.nv-fb-form button{background:#C9A84C;color:#0A0A0A;border:none;border-radius:8px;padding:10px;font-family:Inter,sans-serif;font-size:12px;font-weight:700;cursor:pointer;transition:background .2s}
.nv-fb-form button:hover{background:#D4AF37}
.nv-fb-form button:disabled{opacity:.5;cursor:default}
.nv-fb-label{font-family:Inter,sans-serif;font-size:11px;color:#888;margin-bottom:2px}
.nv-fb-ok{font-family:Inter,sans-serif;font-size:12px;color:#4CAF50;text-align:center;padding:12px}

@media(max-width:500px){
  #nv-chat-win{bottom:0;right:0;left:0;width:100%;max-height:100vh;max-height:100dvh;border-radius:16px 16px 0 0}
  #nv-chat-fab{bottom:16px;right:16px;width:54px;height:54px}
  .nv-ch-body{max-height:calc(100vh - 160px);max-height:calc(100dvh - 160px)}
}
`;
document.head.appendChild(style);

/* ── Build HTML ── */
const fab = document.createElement('button');
fab.id = 'nv-chat-fab';
fab.setAttribute('aria-label','Apri chat assistente');
fab.innerHTML = `<svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#C9A84C" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15a2 2 0 01-2 2H7l-4 4V5a2 2 0 012-2h14a2 2 0 012 2z"/></svg><div id="nv-chat-badge">Posso aiutarti?</div>`;
document.body.appendChild(fab);

const win = document.createElement('div');
win.id = 'nv-chat-win';
win.innerHTML = `
<div class="nv-ch-header">
  <div class="nv-ch-header-info"><div class="nv-ch-header-dot"></div><div class="nv-ch-header-text"><h4>Avv. Vecchioni</h4><span>Assistente riservato</span></div></div>
  <button class="nv-ch-close" aria-label="Chiudi chat"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg></button>
</div>
<div class="nv-ch-body" id="nv-ch-body"></div>
<div class="nv-ch-input">
  <textarea id="nv-ch-ta" rows="1" placeholder="Scrivi un messaggio..." aria-label="Messaggio"></textarea>
  <button class="nv-ch-send" id="nv-ch-send" aria-label="Invia"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#0A0A0A" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/></svg></button>
</div>`;
document.body.appendChild(win);

const body = document.getElementById('nv-ch-body');
const ta = document.getElementById('nv-ch-ta');
const sendBtn = document.getElementById('nv-ch-send');

/* ── Helpers ── */
function scrollBottom(){ requestAnimationFrame(()=>{ body.scrollTop = body.scrollHeight; }); }

function addMsg(role, text, skipSave){
  const div = document.createElement('div');
  div.className = 'nv-msg ' + role;
  div.textContent = text;
  body.appendChild(div);
  scrollBottom();
  if(!skipSave){
    messages.push({role, content: text});
    saveSession();
  }
}

function showQuickReplies(){
  const wrap = document.createElement('div');
  wrap.className = 'nv-qr-wrap';
  QUICK_REPLIES.forEach(txt => {
    const btn = document.createElement('button');
    btn.className = 'nv-qr';
    btn.textContent = txt;
    btn.addEventListener('click', () => {
      wrap.remove();
      sendMessage(txt);
    });
    wrap.appendChild(btn);
  });
  body.appendChild(wrap);
  scrollBottom();
}

function showTyping(){
  if(isTyping) return;
  isTyping = true;
  const d = document.createElement('div');
  d.className = 'nv-typing';
  d.id = 'nv-typing';
  d.innerHTML = '<span></span><span></span><span></span>';
  body.appendChild(d);
  scrollBottom();
}
function hideTyping(){
  isTyping = false;
  const d = document.getElementById('nv-typing');
  if(d) d.remove();
}

/* ── Fallback: mini-form inline nella chat ── */
function showFallbackForm(){
  fallbackMode = true;
  const formDiv = document.createElement('div');
  formDiv.className = 'nv-fb-form';
  formDiv.innerHTML = `
    <div class="nv-fb-label">Lascia i tuoi dati e ti ricontatteremo entro 24 ore:</div>
    <input type="text" id="nv-fb-name" placeholder="Il tuo nome">
    <input type="tel" id="nv-fb-phone" placeholder="Numero di telefono">
    <textarea id="nv-fb-msg" placeholder="Descrivi brevemente la situazione"></textarea>
    <button id="nv-fb-send">INVIA RICHIESTA RISERVATA</button>
  `;
  body.appendChild(formDiv);
  scrollBottom();

  formDiv.querySelector('#nv-fb-send').addEventListener('click', () => {
    const name = formDiv.querySelector('#nv-fb-name').value.trim();
    const phone = formDiv.querySelector('#nv-fb-phone').value.trim();
    const msg = formDiv.querySelector('#nv-fb-msg').value.trim();
    if(!name || !phone){
      [!name ? '#nv-fb-name' : null, !phone ? '#nv-fb-phone' : null].filter(Boolean).forEach(s => {
        const el = formDiv.querySelector(s);
        el.style.borderColor = 'rgba(201,168,76,.8)';
        setTimeout(() => el.style.borderColor = '', 2500);
      });
      return;
    }
    const btn = formDiv.querySelector('#nv-fb-send');
    btn.disabled = true;
    btn.textContent = 'Invio in corso...';
    sendContactEmail(name, phone, msg || '(nessuna descrizione)');
    formDiv.innerHTML = '<div class="nv-fb-ok">Richiesta inviata. L\'Avv. Vecchioni la contatterà entro 24 ore.</div>';
    scrollBottom();
  });
}

/* ── Call Anthropic API directly from browser ── */
async function callAI(conversationHistory){
  if(!ANTHROPIC_API_KEY) return null;

  const apiMessages = conversationHistory
    .filter(m => m.role === 'user' || m.role === 'assistant')
    .map(m => ({role: m.role, content: m.content}));

  const response = await fetch('https://api.anthropic.com/v1/messages', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'x-api-key': ANTHROPIC_API_KEY,
      'anthropic-version': '2023-06-01',
      'anthropic-dangerous-direct-browser-access': 'true'
    },
    body: JSON.stringify({
      model: 'claude-sonnet-4-20250514',
      max_tokens: 300,
      system: SYSTEM_PROMPT,
      messages: apiMessages
    })
  });

  if(!response.ok) throw new Error('API ' + response.status);
  const data = await response.json();
  return data.content && data.content[0] ? data.content[0].text : null;
}

/* ── EmailJS send from chat ── */
function sendContactEmail(name, phone, situation){
  if(typeof emailjs !== 'undefined'){
    emailjs.send(EJS_SERVICE, EJS_TEMPLATE, {
      from_name: name,
      from_phone: phone,
      message: '[Chat Widget] ' + situation,
      reply_to: name
    }, EJS_KEY);
  }
}

/* ── Detect contact confirmation in AI response ── */
function detectContactSend(text){
  const lower = text.toLowerCase();
  if((lower.includes('conferm') || lower.includes('inviat') || lower.includes('ricevut')) && (lower.includes('nome') || lower.includes('telefon'))){
    const nameMatch = text.match(/Nome:\s*(.+?)(?:,|\n|$)/i);
    const phoneMatch = text.match(/Telefono:\s*(.+?)(?:,|\n|$)/i);
    if(nameMatch && phoneMatch){
      const situation = messages.filter(m=>m.role==='user').map(m=>m.content).join(' | ');
      sendContactEmail(nameMatch[1].trim(), phoneMatch[1].trim(), situation);
    }
  }
}

/* ── Send message ── */
async function sendMessage(text){
  if(fallbackMode) return;
  addMsg('user', text);
  sendBtn.disabled = true;
  showTyping();

  try{
    const reply = await callAI(messages);
    hideTyping();
    if(reply){
      addMsg('assistant', reply);
      detectContactSend(reply);
    } else {
      // API key vuota — fallback form
      addMsg('assistant', 'Per garantirle la massima riservatezza, le chiedo di lasciarci i suoi dati. L\'Avv. Vecchioni la ricontatterà personalmente.', false);
      showFallbackForm();
    }
  }catch(e){
    hideTyping();
    console.error('Chat AI error:', e);
    addMsg('assistant', 'Per garantirle la massima riservatezza, le chiedo di lasciarci i suoi dati. L\'Avv. Vecchioni la ricontatterà personalmente.', false);
    showFallbackForm();
  }
  sendBtn.disabled = false;
  if(!fallbackMode) ta.focus();
}

/* ── Init conversation ── */
function initChat(){
  body.innerHTML = '';
  fallbackMode = false;
  if(loadSession() && messages.length > 0){
    messages.forEach(m => addMsg(m.role, m.content, true));
  } else {
    messages = [];
    addMsg('assistant', WELCOME);
    showQuickReplies();
  }
}

/* ── Toggle ── */
function toggle(){
  isOpen = !isOpen;
  win.classList.toggle('open', isOpen);
  fab.classList.toggle('open', isOpen);
  const badge = document.getElementById('nv-chat-badge');
  if(badge) badge.classList.remove('show');
  if(isOpen){
    if(body.children.length === 0) initChat();
    scrollBottom();
    setTimeout(()=> ta.focus(), 350);
  }
}

fab.addEventListener('click', toggle);
win.querySelector('.nv-ch-close').addEventListener('click', toggle);

/* ── Input handling ── */
ta.addEventListener('keydown', e => {
  if(e.key === 'Enter' && !e.shiftKey){
    e.preventDefault();
    const v = ta.value.trim();
    if(!v || sendBtn.disabled) return;
    ta.value = '';
    ta.style.height = 'auto';
    sendMessage(v);
  }
});
sendBtn.addEventListener('click', () => {
  const v = ta.value.trim();
  if(!v || sendBtn.disabled) return;
  ta.value = '';
  ta.style.height = 'auto';
  sendMessage(v);
});
ta.addEventListener('input', () => {
  ta.style.height = 'auto';
  ta.style.height = Math.min(ta.scrollHeight, 80) + 'px';
});

/* ── Close on ESC ── */
document.addEventListener('keydown', e => {
  if(e.key === 'Escape' && isOpen) toggle();
});

/* ── Init on load ── */
initChat();

})();
