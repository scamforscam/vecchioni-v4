<!DOCTYPE html>
<html lang="it">
<head>
<%- include('head.html.tpl', { title: lawyer.studio.name + ' — ' + lawyer.studio.tagline, description: lawyer.hero.subtitle, lawyer, h }) %>
<%- include('styles.html.tpl', { lawyer, h }) %>
</head>
<body>
<%- include('demo-banner.html.tpl', { lawyer, h }) %>
<%- include('nav.html.tpl', { lawyer, h }) %>

<!-- HERO -->
<section class="hero">
  <div class="hero-left">
    <div class="hero-badge"><%= lawyer.hero.eyebrow %></div>
    <h1><%= lawyer.hero.h1White %><br><em><%= lawyer.hero.h1Gold %></em></h1>
    <p class="hero-sub"><%= lawyer.hero.subtitle %></p>
    <div>
      <a href="<%= lawyer.hero.ctaTarget %>" class="btn"><%= lawyer.hero.ctaText %></a>
      <p class="microcopy"><%= lawyer.hero.microcopy %></p>
      <p style="margin-top:20px;font-size:12px;font-weight:600;letter-spacing:.06em;color:var(--grey-d);text-transform:uppercase"><%= lawyer.hero.caption %></p>
    </div>
  </div>
  <% if (lawyer.lawyer.photoHero) { %>
  <div class="hero-right">
    <img src="<%= lawyer.lawyer.photoHero %>" alt="<%= lawyer.studio.name %>" class="hero-img" onerror="this.style.display='none'">
  </div>
  <% } %>
</section>

<!-- CRED BAR -->
<div class="cred-bar"><div class="cred-inner">
  <% lawyer.credentials.credBar.forEach(c => { %>
    <div class="cred-item"><div class="cred-num"><%= c.num %></div><div class="cred-lbl"><%= c.label %></div></div>
  <% }); %>
</div></div>

<!-- AREE -->
<section class="sec" id="aree" style="background:var(--black)">
  <div class="wrap">
    <p class="lbl"><%= lawyer.areas.label %></p>
    <h2 class="st"><%= lawyer.areas.h2White %><br><em><%= lawyer.areas.h2Gold %></em></h2>
    <div class="areas-grid">
      <% lawyer.areas.items.filter(a => a.slug !== '_catchall').forEach(a => { %>
        <a href="<%= a.hasDetailPage ? a.slug + '.html' : (a.href || '#contatti') %>" class="area-card">
          <div class="area-icon" aria-hidden="true">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/></svg>
          </div>
          <div class="area-title"><%= a.title %></div>
          <div class="area-desc"><%= a.cardDesc %></div>
          <div class="area-arrow"><span><%= a.ctaText %></span><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></div>
        </a>
      <% }); %>
    </div>
  </div>
</section>

<!-- CHI SONO -->
<section class="sec" id="chi-sono" style="background:var(--anthracite)">
  <div class="wrap" style="max-width:760px">
    <p class="lbl"><%= lawyer.chiSono.label %></p>
    <h2 class="st" style="font-family:var(--font-serif);font-weight:400"><%= lawyer.lawyer.fullName %></h2>
    <p style="margin-top:-10px;font-size:11px;letter-spacing:.14em;text-transform:uppercase;color:var(--gold);font-weight:700;margin-bottom:32px"><%= lawyer.lawyer.title %> · <%= lawyer.credentials.court %></p>
    <% if (lawyer.lawyer.photoMain) { %>
      <div style="aspect-ratio:4/5;max-width:420px;background:var(--anthracite);margin:0 0 36px;overflow:hidden">
        <img src="<%= lawyer.lawyer.photoMain %>" alt="<%= lawyer.lawyer.fullName %>" style="width:100%;height:100%;object-fit:cover;object-position:center top" onerror="this.style.display='none'">
      </div>
    <% } %>
    <p style="font-family:var(--font-serif);font-size:clamp(1.4rem,2.6vw,1.75rem);line-height:1.3;color:var(--white);margin:0 0 28px"><%= lawyer.lawyer.bio.thesisWhite %><br><em style="font-style:italic;font-weight:700;color:var(--gold)"><%= lawyer.lawyer.bio.thesisGold %></em></p>
    <% lawyer.lawyer.bio.paragraphs.forEach((p, i) => { %>
      <p class="bt" style="margin-bottom:24px"><%- p.text %><% if (p.bold) { %><strong style="color:#fff;font-weight:700"><%= p.bold %></strong><% } %><% if (p.tail) { %><%- p.tail %><% } %></p>
      <% if (i < lawyer.lawyer.bio.paragraphs.length - 1) { %><div style="width:40px;height:2px;background:var(--gold);margin:20px 0;opacity:.5"></div><% } %>
    <% }); %>
    <div style="width:40px;height:2px;background:var(--gold);margin:20px 0;opacity:.5"></div>
    <p class="bt" style="color:var(--white);font-weight:500"><%= lawyer.lawyer.bio.closing %></p>
    <div style="display:flex;gap:14px;margin-top:32px;flex-wrap:wrap">
      <% lawyer.lawyer.badges.forEach(b => { %>
        <div style="display:inline-flex;align-items:center;gap:8px;border:1px solid var(--border);padding:8px 14px;font-size:12px;color:var(--gold);font-weight:600"><%= b.label %></div>
      <% }); %>
    </div>
    <div style="margin-top:28px"><a href="#contatti" class="btn" style="padding:15px 36px;font-size:.82rem">Contattami</a></div>
  </div>
</section>

<!-- IL METODO -->
<section class="sec" style="background:var(--black)">
  <div class="wrap">
    <p class="lbl"><%= lawyer.method.label %></p>
    <div style="padding:48px 56px;border-left:3px solid var(--gold);background:var(--gold-dim);margin:32px 0 72px;max-width:960px">
      <p style="font-family:var(--font-serif);font-size:clamp(1.25rem,2.5vw,1.65rem);font-style:italic;color:var(--white);line-height:1.5">"<%= lawyer.method.quote %>"</p>
    </div>
    <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:1px;background:var(--border);border:1px solid var(--border)">
      <% lawyer.method.pillars.forEach(p => { %>
        <div style="background:var(--anthracite);padding:44px 36px">
          <div style="font-size:11px;font-weight:700;letter-spacing:.14em;color:var(--gold);margin-bottom:20px"><%= p.num %></div>
          <div style="font-size:1.2rem;font-weight:700;color:var(--white);margin-bottom:12px"><%= p.title %></div>
          <p style="font-size:14px;color:var(--grey);line-height:1.65"><%= p.text %></p>
        </div>
      <% }); %>
    </div>
  </div>
</section>

<!-- DISCREZIONE -->
<section class="sec" id="risultati" style="background:var(--anthracite)">
  <div class="wrap" style="max-width:760px">
    <p class="lbl"><%= lawyer.discrezione.label %></p>
    <h2 class="st"><%= lawyer.discrezione.h2White %><br><em><%= lawyer.discrezione.h2Gold %></em></h2>
    <div style="margin-top:40px">
      <% lawyer.discrezione.paragraphs.forEach(p => { %>
        <p style="font-size:1.0625rem;line-height:1.75;margin-bottom:22px;color:var(--grey)"><%= p %></p>
      <% }); %>
    </div>
    <div style="margin-top:44px"><a href="#contatti" class="btn" style="text-transform:none;letter-spacing:.01em"><%= lawyer.discrezione.cta %></a></div>
  </div>
</section>

<!-- FAQ -->
<section class="sec" style="background:var(--black)">
  <div class="wrap">
    <p class="lbl"><%= lawyer.faq.label %></p>
    <h2 class="st"><%= lawyer.faq.h2White %></h2>
    <div style="border:1px solid var(--border);margin-top:48px;max-width:880px">
      <% lawyer.faq.items.forEach((f, idx) => { %>
        <details style="border-bottom:1px solid var(--border)">
          <summary style="cursor:pointer;padding:24px 28px;font-size:1.05rem;font-weight:700;color:var(--white);list-style:none"><%- f.q %></summary>
          <div style="padding:0 28px 24px;font-size:14px;color:var(--grey);line-height:1.7;max-width:720px"><%- f.a %></div>
        </details>
      <% }); %>
    </div>
  </div>
</section>

<!-- CTA + FORM -->
<section class="sec" id="contatti" style="background:var(--anthracite)">
  <div class="wrap" style="display:grid;grid-template-columns:1fr 1fr;gap:80px;align-items:flex-start">
    <div>
      <p class="lbl"><%= lawyer.contattiSection.label %></p>
      <h2 class="st"><%= lawyer.contattiSection.h2White %><br><em><%= lawyer.contattiSection.h2Gold %></em></h2>
      <div style="border-left:2px solid var(--gold);padding:14px 20px;background:var(--gold-dim);font-size:1rem;color:var(--white);font-weight:600;line-height:1.5;margin:20px 0 28px"><%= lawyer.contattiSection.urgencyDefault %></div>
      <div style="display:flex;flex-direction:column;gap:14px;margin-top:24px">
        <% lawyer.contattiSection.trustList.forEach(t => { %>
          <div style="display:flex;align-items:center;gap:12px;font-size:14px;color:var(--grey)"><div style="width:6px;height:6px;background:var(--gold);flex-shrink:0"></div><%= t %></div>
        <% }); %>
      </div>
    </div>
    <%- include('form-contatti.html.tpl', { lawyer, h }) %>
  </div>
</section>

<%- include('footer.html.tpl', { lawyer, h }) %>

<script>
'use strict';
const nav=document.getElementById('nav');
window.addEventListener('scroll',()=>{nav.classList.toggle('scrolled',window.scrollY>60)},{passive:true});
<% if (lawyer.form.provider === 'emailjs' && lawyer.form.emailjs) { %>
// EmailJS init (con safety try/catch)
const EJS_PUBLIC_KEY='<%= lawyer.form.emailjs.publicKey %>';
const EJS_SERVICE_ID='<%= lawyer.form.emailjs.serviceId %>';
const EJS_TEMPLATE_ID='<%= lawyer.form.emailjs.templateId %>';
const EJS_FALLBACK_MSG=<%- JSON.stringify(lawyer.form.fallbackMessage) %>;
const form=document.getElementById('contact-form'),succ=document.getElementById('form-success');
if(form){form.addEventListener('submit',e=>{e.preventDefault();let v=true;<% lawyer.form.fields.forEach(f=>{ %>['<%= f.id %>']<% }); %>;const fields=<%- JSON.stringify(lawyer.form.fields.map(f=>f.id)) %>;fields.forEach(id=>{const el=document.getElementById(id);if(!el.value.trim()){v=false;el.style.borderColor='rgba(201,168,76,.8)';setTimeout(()=>{el.style.borderColor=''},2500)}});if(!v)return;
const btn=form.querySelector('.form-submit');btn.disabled=true;btn.textContent='Invio in corso…';
const params={from_name:document.getElementById('f-name')?.value.trim()||'',from_phone:document.getElementById('f-phone')?.value.trim()||''};
if(typeof emailjs==='undefined'||!emailjs.send){btn.disabled=false;btn.textContent='<%= lawyer.form.ctaText %>';alert(EJS_FALLBACK_MSG);return}
try{emailjs.send(EJS_SERVICE_ID,EJS_TEMPLATE_ID,params).then(()=>{form.style.display='none';succ.style.display='block'}).catch(err=>{console.error(err);btn.disabled=false;btn.textContent='<%= lawyer.form.ctaText %>';alert(EJS_FALLBACK_MSG)})}catch(err){console.error(err);btn.disabled=false;btn.textContent='<%= lawyer.form.ctaText %>';alert(EJS_FALLBACK_MSG)}})}
try{if(typeof emailjs!=='undefined')emailjs.init({publicKey:EJS_PUBLIC_KEY})}catch(e){console.warn('EmailJS init failed',e)}
<% } else { %>
// Form fallback (no provider configured)
const form=document.getElementById('contact-form'),succ=document.getElementById('form-success');
if(form){form.addEventListener('submit',e=>{e.preventDefault();form.style.display='none';succ.style.display='block'})}
<% } %>
</script>
<% if (lawyer.form.provider === 'emailjs') { %><script src="https://cdn.jsdelivr.net/npm/@emailjs/browser@4/dist/email.min.js"></script><% } %>
<% if (lawyer.chat.enabled && lawyer.chat.scriptSrc) { %><script src="<%= lawyer.chat.scriptSrc %>"></script><% } %>
</body>
</html>
