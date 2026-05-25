/**
 * Helper: genera un nuovo file data/demos/{slug}.json a partire da
 * uno scaffold di base. Da usare dal comando /demo o manualmente.
 *
 * Usage:
 *   node scripts/new-demo.js <slug> '<JSON-overrides>'
 *
 * Esempio:
 *   node scripts/new-demo.js rossi '{"studio":{"name":"Studio Avv. Mario Rossi","shortName":"Avv. Rossi","tagline":"Penalista — Torino","logoMark":"MR"},"contacts":{"email":"info@example.it"}}'
 *
 * Lo slug è il cognome minuscolo (senza spazi).
 */

'use strict';

const fs   = require('fs');
const path = require('path');

const slug = process.argv[2];
const overridesRaw = process.argv[3] || '{}';

if (!slug || !/^[a-z0-9-]+$/.test(slug)) {
  console.error('ERRORE: slug mancante o non valido (solo a-z, 0-9, "-")');
  console.error('Usage: node scripts/new-demo.js <slug> [JSON-overrides]');
  process.exit(1);
}

const ROOT      = path.resolve(__dirname, '..');
const EXAMPLE   = path.join(ROOT, 'data', 'demos', '_example.json');
const TARGET    = path.join(ROOT, 'data', 'demos', `${slug}.json`);

if (fs.existsSync(TARGET)) {
  console.error(`ERRORE: ${TARGET} esiste già. Cancellalo prima di rigenerarlo.`);
  process.exit(1);
}

const base = JSON.parse(fs.readFileSync(EXAMPLE, 'utf8'));
let overrides;
try {
  overrides = JSON.parse(overridesRaw);
} catch (e) {
  console.error('ERRORE: JSON-overrides non valido:', e.message);
  process.exit(1);
}

// Deep merge banale (sovrascrive ricorsivamente)
function merge(target, src) {
  for (const k of Object.keys(src)) {
    if (src[k] && typeof src[k] === 'object' && !Array.isArray(src[k]) && target[k]) {
      merge(target[k], src[k]);
    } else {
      target[k] = src[k];
    }
  }
  return target;
}

const out = merge(base, overrides);
out.slug = slug;
out._comment = `Demo per ${out.studio?.name || slug}. Generato il ${new Date().toISOString()}.`;
out.demoMeta.isDemo = true;
out.demoMeta.createdAt = new Date().toISOString().slice(0, 10);

fs.writeFileSync(TARGET, JSON.stringify(out, null, 2));
console.log(`✓ Creato data/demos/${slug}.json`);
console.log(`  Personalizza il file, poi lancia: npm run build`);
console.log(`  URL locale dopo build: http://localhost:8000/demo/${slug}/`);
