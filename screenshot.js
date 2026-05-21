const puppeteer = require('puppeteer');
const path = require('path');
const fs = require('fs');

(async () => {
  const browser = await puppeteer.launch({ headless: true, args: ['--no-sandbox'] });
  const page = await browser.newPage();

  const files = fs.readdirSync('.').filter(f => f.endsWith('.html'));

  for (const file of files) {
    const filePath = 'file://' + path.resolve(file);
    console.log(`Screenshot: ${file}`);

    // Desktop
    await page.setViewport({ width: 1440, height: 900 });
    await page.goto(filePath, { waitUntil: 'networkidle0', timeout: 15000 });
    await new Promise(r => setTimeout(r, 1500));
    await page.screenshot({ path: `screenshot-${file.replace('.html','')}-desktop.png`, fullPage: true });

    // Mobile
    await page.setViewport({ width: 390, height: 844 });
    await new Promise(r => setTimeout(r, 800));
    await page.screenshot({ path: `screenshot-${file.replace('.html','')}-mobile.png`, fullPage: true });

    console.log(`  ✅ ${file} done`);
  }

  await browser.close();
  console.log('Screenshot completati!');
})();
