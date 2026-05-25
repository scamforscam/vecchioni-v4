---
description: Genera una nuova demo (sito plausibile per uno studio legale) a partire da URL o info testuali. Crea data/demos/{slug}.json + esegue build + restituisce URL locale.
---

Sei dentro al repo `vecchioni-v4` — una "fabbrica di demo" per acquisire avvocati come clienti.

L'utente vuole generare una NUOVA demo. L'input può essere:
- **(a) Un URL** del sito attuale di un avvocato → fetcha + estrai nome, studio, materie, foro, città, contatti.
- **(b) Info testuali** (nome, materie, città) → usa quelle.

## Passo dopo passo

### 1. Analizza l'input
Se contiene `http://` o `https://`:
- Usa `WebFetch` sull'URL per estrarre: nome avvocato, nome studio, tagline/headline, materie/aree, foro o città, email/telefono se pubblici, eventuali colori del brand.
- **MAI copiare letteralmente i testi del sito originale**. Devi solo capire CHI è l'avvocato e di cosa si occupa. I testi finali sono tutti nuovi.

Altrimenti (info testuali): parsa nome, città, materie principali. Se manca qualcosa di critico (es. cognome) **chiedi all'utente** prima di generare.

### 2. Determina lo slug
`{slug} = cognome minuscolo senza spazi né accenti` (es. "Avv. Mario Rossi" → `rossi`, "D'Alessio" → `dalessio`).

Verifica che `data/demos/{slug}.json` NON esista. Se esiste, chiedi se sovrascrivere.

### 3. Genera testi NUOVI in italiano sobrio professionale

Scrivi da zero, **senza copiare nulla** dal sito sorgente:
- **Hero H1** breve, in 2 righe (riga bianca + riga oro corsivo) — tono empatico, niente promesse esagerate.
- **Hero subtitle**: 1-2 frasi sobrie sul valore offerto.
- **Bio Chi Sono**: 2-3 paragrafi brevi, professionali. Niente "vantati", niente nomi di clienti, niente percentuali di vittorie.
- **3 pillars del Metodo**: es. Riservatezza / Onestà / Tecnica (o varianti pertinenti).
- **3 paragrafi Discrezione**: declinazione del principio "niente vetrina dei casi".
- **Aree (3-5)**: titoli + descrizioni brevi delle materie principali del cliente. Per ognuna:
  - `slug` (es. `stupefacenti`, `reati-strada`)
  - `title`
  - `subtitle` (1 riga)
  - `cardDesc` (2 righe)
  - `icon` (uno tra: `user`, `users`, `package`, `pill`, `car-front`, `landmark`, `briefcase`, `shield`)
  - `hasDetailPage`: `false` di default (PDP dedicate sono opzionali, vedi sotto)
- **FAQ home (3-5 Q&A)**: domande tipiche del cliente (costo, urgenza, fiducia).
- **Form**: `provider: "none"` (il submit mostra solo l'animazione, niente invio reale).
- **Chat**: `enabled: false` di default.

### 4. Scegli una palette sobria

NON usare la palette di Vecchioni (`#C9A84C` gold + `#0A0A0A` nero) per evitare che tutte le demo sembrino uguali. Scegli una combinazione adatta a uno studio legale:

- **Bordeaux + crema**: `gold: "#8B3A3A"`, `goldHover: "#A04848"`
- **Blu navy + ocra**: `gold: "#B8923A"`, su `black: "#0A1628"`
- **Verde foresta + rame**: `gold: "#B87333"`, su `black: "#0D1A12"`
- **Antracite + oro chiaro**: `gold: "#D4AF7A"`, su `black: "#0E0E0E"`
- **Nero + argento**: `gold: "#A8A8B0"`, su `black: "#0A0A0A"`

Adatta alla città/personalità dell'avvocato se hai indicazioni. Mantieni il resto della palette coerente (anthracite scuro, border `#333`, cream `#E8E5DE`).

### 5. Banner demo

Imposta `demoMeta`:
- `isDemo: true`
- `agencyName`: chiedi all'utente come si chiama la sua agenzia (oppure usa un placeholder editabile)
- `ctaPersonalUrl`: chiedi se vuole un link WhatsApp/calendly per il "Parliamone"
- `createdAt`: data odierna
- `createdFromUrl`: l'URL originale (se input era URL), `null` altrimenti

### 6. Genera il file JSON

Crea `data/demos/{slug}.json` con la struttura di `data/demos/_example.json`. Compila TUTTI i campi (anche quelli non popolati dal sito sorgente, con valori sensati).

Schema completo documentato in `CLAUDE.md`.

### 7. Build & verifica

```bash
npm run build
```

Verifica che `dist/demo/{slug}/index.html` esista e abbia HTTP 200 quando servito.

### 8. Restituisci all'utente

- URL locale: `http://localhost:8000/demo/{slug}/`
- URL Vercel preview: se il repo è collegato a Vercel, dopo il prossimo `git push` su un branch arriverà una preview URL `https://{branch}-{...}.vercel.app/demo/{slug}/`. In alternativa: `vercel --prod` deploya la versione corrente.
- Riepilogo: nome, palette scelta, aree generate, URL.

## Vincoli operativi

- **Mai copiare testi**: ogni testo deve essere scritto da zero. Riformulazione VIETATA.
- **Mai inventare numeri specifici**: "18 anni di esperienza" del sito sorgente NON va riportato come è. Se non sai l'esperienza reale, scrivi qualcosa di neutro tipo "Pratica penalistica" senza numero.
- **Mai promesse di risultati**: niente "ti faccio assolvere", niente "casi vinti", niente percentuali. Lo studio penalista è soggetto al divieto deontologico (art. 35 c.d.f. e art. 37 sull'accaparramento).
- **Foto reali**: non includere foto del avvocato reale. Il sito demo non ha foto (placeholder neri) finché il cliente non firma il contratto.
- **Lavora su branch dedicato**: `demo/{slug}` se la demo richiede commit. Per demo "quick draft" può rimanere tutto uncommitted.
- **NO push automatico**: chiedi sempre conferma prima di pushare.
