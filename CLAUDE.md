# vecchioni-v4 — Fabbrica di demo per studi legali

Questo repo serve **due** scopi:

1. **Sito del cliente reale** — `Avv. Niccolò Vecchioni` (live su Netlify, file HTML in root).
2. **Fabbrica di demo** per acquisire nuovi avvocati: un solo data file → un sito intero generato in `dist/`.

## Architettura

```
data/
├── lawyer.json              # Sorgente per il sito principale (Vecchioni)
└── demos/
    ├── _example.json        # Template di partenza per nuove demo
    └── {slug}.json          # Una demo per file (slug = cognome lowercase)

templates/                   # Template EJS (.html.tpl)
├── index.html.tpl
├── area.html.tpl            # Generico — genera una pdp per ogni areas[].hasDetailPage:true
├── privacy.html.tpl
├── cookie.html.tpl
└── note-legali.html.tpl

partials/                    # Frammenti riusabili
├── head.html.tpl
├── styles.html.tpl
├── nav.html.tpl
├── footer.html.tpl
├── form-contatti.html.tpl
└── demo-banner.html.tpl     # Fascia "Bozza dimostrativa" — mostrata solo se isDemo:true

scripts/
├── build.js                 # node scripts/build.js → genera tutto in dist/
└── new-demo.js              # node scripts/new-demo.js <slug> '<JSON>'

dist/                        # OUTPUT (gitignored)
├── index.html               # Home Vecchioni
├── {area}.html              # PDP Vecchioni (una per ogni area con hasDetailPage)
├── privacy.html, cookie.html, note-legali.html
├── demo/
│   └── {slug}/
│       ├── index.html
│       ├── {area}.html
│       └── privacy.html, ...
└── images/                  # copiate da images/

api/chat.js                  # Serverless function Vercel (proxy Anthropic) — usata solo se chat.enabled
chat-widget.js               # Widget chat, attivo solo se lawyer.chat.enabled === true
```

## Come funziona

1. **`scripts/build.js`** legge `data/lawyer.json` + tutti i `data/demos/*.json`.
2. Per ogni "tenant" (lawyer principale + ogni demo) chiama EJS sui template:
   - `index.html.tpl` → `dist/[demo/{slug}/]index.html`
   - `area.html.tpl` → `dist/[demo/{slug}/]{area.slug}.html` (uno per area con `hasDetailPage:true`)
   - `privacy.html.tpl`, `cookie.html.tpl`, `note-legali.html.tpl` → idem
3. Copia `images/` e `chat-widget.js` in `dist/`.

## Schema `lawyer.json`

Documentato dentro `data/lawyer.json` (Vecchioni) e `data/demos/_example.json` (template demo).

Campi chiave:

| Campo | Tipo | Note |
|---|---|---|
| `slug` | string | identificativo univoco (`vecchioni`, `rossi`, ecc.) |
| `studio.{name,shortName,tagline,logoMark}` | string | brand |
| `lawyer.{fullName,title,role,bio,badges}` | mixed | persona e biografia |
| `credentials.{court,order,cassazioneIscritto,credBar}` | mixed | foro + cred-bar |
| `contacts.{email,address,emergencyLine}` | mixed | contatti |
| `brand.palette` | object | colori CSS variables |
| `brand.fonts.{serif,sans,serifQuery,sansQuery}` | string | font + parametro Google Fonts |
| `hero` | object | hero della home |
| `areas.items[]` | array | aree pratica. Ogni elemento può avere `hasDetailPage:true` → genera una PDP separata |
| `method.pillars[]`, `discrezione`, `faq` | mixed | sezioni home |
| `form.{provider,emailjs,fallbackMessage}` | mixed | provider supportati: `emailjs`, `none` |
| `chat.{enabled,scriptSrc}` | mixed | chat widget (default disattivata su demo) |
| `legal.{privacy,cookie,noteLegali}.draft` | bool | mostra banner "BOZZA" sulle pagine legali |
| `demoMeta.{isDemo,agencyName,ctaPersonalUrl,ctaPersonalLabel}` | mixed | meta della demo |

## Generare una nuova demo — manuale

```bash
# 1. Copia il template
cp data/demos/_example.json data/demos/{cognome}.json

# 2. Modifica il file con i dati del nuovo avvocato
#    (almeno: slug, studio, lawyer, contacts, credentials, hero, areas, demoMeta)

# 3. Build
npm run build

# 4. Vedi in locale
npm run dev   # serve dist/ su http://localhost:8000/
# Demo all'URL: http://localhost:8000/demo/{cognome}/
```

## Generare una nuova demo — automatico (`/demo`)

Vedi `.claude/commands/demo.md`. Sintassi:

```
/demo https://www.studiorossi.it/
```

oppure:

```
/demo Avv. Mario Rossi, penalista Torino, materie: stupefacenti, reati patrimonio
```

Il comando:
1. Se input è URL → fetcha la pagina, estrae nome/studio/materie/contatti.
2. Genera testi NUOVI in italiano sobrio professionale (mai copiati).
3. Sceglie una palette colori adeguata.
4. Crea `data/demos/{slug}.json`.
5. Esegue `npm run build`.
6. Restituisce URL locale + URL Vercel (se collegato).

## Deploy Vercel

```bash
# Una volta sola
npm i -g vercel
vercel login
vercel link            # collega cartella a un progetto Vercel
vercel env add ANTHROPIC_API_KEY production
vercel --prod          # primo deploy

# Da quel momento ogni push su master → deploy automatico
# Ogni push su branch → preview URL automatica
```

**Build config Vercel** (in `vercel.json`):
- `buildCommand`: `npm run build`
- `outputDirectory`: `dist`
- `framework`: `null` (statico puro)

## Demo: banner, noindex, CTA

Quando `demoMeta.isDemo === true`:
- Fascia in alto **"Bozza dimostrativa per {studio.name} — realizzata da {agencyName}"** con CTA "Parliamone" → `demoMeta.ctaPersonalUrl`.
- Meta tag `<meta name="robots" content="noindex,nofollow">` su ogni pagina.
- `chat.enabled: false` di default (niente costi Anthropic API su demo non convertite).
- `form.provider: "none"` di default (il submit mostra solo l'animazione, non invia davvero).

## File legacy

Gli HTML originali in root (`index.html`, `stupefacenti.html`, ...) **NON** sono ancora rimpiazzati dal sistema templatizzato. Restano serviti da Netlify (zero downtime). La migrazione completa nel sistema build è **milestone 2** (dopo verifica identità).

## Comandi npm

| Comando | Cosa fa |
|---|---|
| `npm run build` | Genera `dist/` da `data/` + `templates/` |
| `npm run dev` | Build + serve `dist/` su `http://localhost:8000` |
