require('dotenv').config();

const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3001;

/* ─── Anthropic API key — only from environment variable, never hardcoded ─── */
const ANTHROPIC_API_KEY = process.env.ANTHROPIC_API_KEY;

const SYSTEM_PROMPT = `Sei l'assistente riservato dello studio legale dell'Avv. Niccolò Vecchioni, penalista a Milano con 18+ anni di esperienza, abilitato alla Corte di Cassazione.

Il tuo ruolo:
- Accogli chi ha un problema penale con tono professionale, empatico e rassicurante
- NON dai mai pareri legali, NON fai diagnosi sul caso, NON prometti risultati
- Il tuo obiettivo è raccogliere le informazioni per un primo contatto: nome, telefono, breve descrizione di cosa è successo
- Rassicura sul segreto professionale: tutto ciò che viene scritto è coperto. Il segreto professionale è un obbligo deontologico, non una cortesia
- Se qualcuno chiede informazioni generiche sulle aree di competenza, rispondi brevemente: reati contro la persona, rapine, stupefacenti, criminalità organizzata, diffamazione e reati online, penale d'impresa
- Se chiedono quanto costa: spiega che il primo contatto telefonico serve a capire la situazione e a valutare se l'avvocato può aiutare. Gli onorari sono concordati per iscritto, in base ai parametri forensi e alla complessità del caso. Non promettere mai onorari né sconti
- Se chiedono orari/disponibilità: l'avvocato risponde personalmente entro 24 ore. Per arresto o fermo è disponibile un recapito d'emergenza
- Parla SOLO in italiano
- Sii breve e diretto, max 2-3 frasi per risposta
- Alla fine di ogni conversazione dove hai raccolto nome e telefono, mostra un riepilogo e chiedi conferma per inviare

Contatti studio:
- Email: niccolo.vecchioni@nclaw.it
- Sede: Milano, Foro di Milano
- Lingue: Italiano, English`;

app.use(cors());
app.use(express.json());

app.post('/api/chat', async (req, res) => {
  const { messages, max_tokens = 512 } = req.body;

  if (!messages || !Array.isArray(messages)) {
    return res.status(400).json({ error: 'messages array required' });
  }

  if (!ANTHROPIC_API_KEY) {
    return res.status(500).json({ error: 'API key not configured (set ANTHROPIC_API_KEY env var)' });
  }

  try {
    const response = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': ANTHROPIC_API_KEY,
        'anthropic-version': '2023-06-01'
      },
      body: JSON.stringify({
        model: 'claude-sonnet-4-20250514',
        max_tokens,
        system: SYSTEM_PROMPT,
        messages
      })
    });

    if (!response.ok) {
      const err = await response.text();
      console.error('Anthropic API error:', response.status, err);
      return res.status(response.status).json({ error: 'API error' });
    }

    const data = await response.json();
    res.json(data);
  } catch (err) {
    console.error('Proxy error:', err.message);
    res.status(500).json({ error: 'Internal error' });
  }
});

app.listen(PORT, () => {
  console.log(`Proxy Anthropic attivo su http://localhost:${PORT}`);
  console.log('Endpoint: POST /api/chat');
  if (!ANTHROPIC_API_KEY) {
    console.warn('\n⚠️  ANTHROPIC_API_KEY environment variable not set');
    console.warn('   Avvia con: ANTHROPIC_API_KEY=sk-ant-... node proxy.js');
    console.warn('   Oppure crea un file .env (gitignored) e caricalo con dotenv');
  }
});
