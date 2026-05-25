/**
 * Build engine — "demo factory" per siti studi legali.
 *
 * Legge:
 *   - data/lawyer.json                    -> sito principale (es. Vecchioni)
 *   - data/demos/*.json                   -> ogni file = una demo separata
 *   - templates/*.html.tpl                -> template EJS della home + area + legali
 *   - partials/*.html.tpl                 -> frammenti (nav, footer, form, chat)
 *
 * Genera:
 *   - dist/index.html                     -> home Vecchioni
 *   - dist/{area.slug}.html               -> una per ogni area del lawyer principale
 *   - dist/privacy.html, /cookie.html, /note-legali.html
 *   - dist/demo/{slug}/index.html         -> home demo
 *   - dist/demo/{slug}/{area.slug}.html   -> aree demo
 *   - dist/demo/{slug}/privacy.html, ...
 *   - Copia images/, chat-widget.js (se chat attiva), api/ in dist/
 *
 * Usage:
 *   node scripts/build.js
 */

'use strict';

const fs   = require('fs');
const path = require('path');
const ejs  = require('ejs');

const ROOT      = path.resolve(__dirname, '..');
const DATA_DIR  = path.join(ROOT, 'data');
const DEMOS_DIR = path.join(DATA_DIR, 'demos');
const TPL_DIR   = path.join(ROOT, 'templates');
const PART_DIR  = path.join(ROOT, 'partials');
const DIST_DIR  = path.join(ROOT, 'dist');
const IMG_DIR   = path.join(ROOT, 'images');

const TEMPLATES = {
  index:      'index.html.tpl',
  area:       'area.html.tpl',
  privacy:    'privacy.html.tpl',
  cookie:     'cookie.html.tpl',
  noteLegali: 'note-legali.html.tpl',
};

// ────────────────────────────────────────────────────────────────
// Utility filesystem
// ────────────────────────────────────────────────────────────────

function rmrf(dir) {
  if (fs.existsSync(dir)) fs.rmSync(dir, { recursive: true, force: true });
}

function mkdirp(dir) {
  fs.mkdirSync(dir, { recursive: true });
}

function copyDir(src, dst) {
  if (!fs.existsSync(src)) return;
  mkdirp(dst);
  for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
    const s = path.join(src, entry.name);
    const d = path.join(dst, entry.name);
    if (entry.isDirectory()) copyDir(s, d);
    else fs.copyFileSync(s, d);
  }
}

function readJson(file) {
  return JSON.parse(fs.readFileSync(file, 'utf8'));
}

function writeOut(relPath, content) {
  const out = path.join(DIST_DIR, relPath);
  mkdirp(path.dirname(out));
  fs.writeFileSync(out, content);
}

// ────────────────────────────────────────────────────────────────
// EJS render con partials risolti relativamente a partials/
// ────────────────────────────────────────────────────────────────

function render(tplName, data, opts = {}) {
  const tplPath = path.join(TPL_DIR, tplName);
  const tpl = fs.readFileSync(tplPath, 'utf8');
  return ejs.render(tpl, data, {
    filename: tplPath,
    views: [TPL_DIR, PART_DIR],
    ...opts,
  });
}

// ────────────────────────────────────────────────────────────────
// Build di un singolo "tenant" (lawyer principale o demo)
// ────────────────────────────────────────────────────────────────

function buildTenant(lawyer, outBase) {
  const ctx = {
    lawyer,
    // helper inline
    h: {
      isDemo: !!lawyer.demoMeta?.isDemo,
      pathPrefix: outBase ? '../'.repeat(outBase.split('/').filter(Boolean).length) : '',
      assetPath: (p) => outBase ? `${outBase.split('/').filter(Boolean).map(_ => '..').join('/')}/${p}` : p,
    },
  };

  // home
  writeOut(
    path.join(outBase, 'index.html'),
    render(TEMPLATES.index, ctx)
  );

  // aree (una pdp per ogni elemento di lawyer.areas.items che ha hasDetailPage:true)
  const areaList = (lawyer.areas?.items || lawyer.areas || []).filter(a => a.hasDetailPage);
  for (const area of areaList) {
    writeOut(
      path.join(outBase, `${area.slug}.html`),
      render(TEMPLATES.area, { ...ctx, area })
    );
  }

  // pagine legali
  if (lawyer.legal?.privacy) {
    writeOut(path.join(outBase, 'privacy.html'),     render(TEMPLATES.privacy, ctx));
  }
  if (lawyer.legal?.cookie) {
    writeOut(path.join(outBase, 'cookie.html'),      render(TEMPLATES.cookie, ctx));
  }
  if (lawyer.legal?.noteLegali) {
    writeOut(path.join(outBase, 'note-legali.html'), render(TEMPLATES.noteLegali, ctx));
  }
}

// ────────────────────────────────────────────────────────────────
// Main
// ────────────────────────────────────────────────────────────────

function main() {
  console.log('[build] start');
  rmrf(DIST_DIR);
  mkdirp(DIST_DIR);

  // ───── sito principale (Vecchioni)
  const lawyerMain = readJson(path.join(DATA_DIR, 'lawyer.json'));
  console.log(`[build] tenant principale: ${lawyerMain.studio.shortName} (slug ${lawyerMain.slug})`);
  buildTenant(lawyerMain, '');

  // ───── demo (cartella opzionale)
  if (fs.existsSync(DEMOS_DIR)) {
    const demoFiles = fs.readdirSync(DEMOS_DIR)
      .filter(f => f.endsWith('.json') && !f.startsWith('_'));
    for (const file of demoFiles) {
      const demo = readJson(path.join(DEMOS_DIR, file));
      const slug = demo.slug || path.basename(file, '.json');
      console.log(`[build] demo: ${demo.studio?.shortName || slug} -> /demo/${slug}/`);
      buildTenant(demo, path.join('demo', slug));
    }
  }

  // ───── asset shared
  copyDir(IMG_DIR, path.join(DIST_DIR, 'images'));
  if (fs.existsSync(path.join(ROOT, 'chat-widget.js'))) {
    fs.copyFileSync(path.join(ROOT, 'chat-widget.js'), path.join(DIST_DIR, 'chat-widget.js'));
  }

  // api/ è gestita direttamente da Vercel come serverless function (non va in dist/)

  console.log('[build] done -> dist/');
}

main();
