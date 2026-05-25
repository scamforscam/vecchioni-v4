<!DOCTYPE html>
<html lang="it">
<head>
<%- include('head.html.tpl', { title: 'Cookie Policy — ' + lawyer.studio.shortName, description: 'Cookie policy', lawyer, h }) %>
<%- include('styles.html.tpl', { lawyer, h }) %>
</head>
<body>
<%- include('demo-banner.html.tpl', { lawyer, h }) %>
<%- include('nav.html.tpl', { lawyer, h }) %>
<section class="sec" style="padding-top:140px">
  <div class="wrap" style="max-width:780px">
    <% if (lawyer.legal.cookie.draft) { %>
      <div style="background:rgba(220,150,80,.1);border:1px solid rgba(220,150,80,.4);padding:20px;margin-bottom:32px;font-size:13px;color:var(--cream)"><strong style="color:var(--gold)">⚠ BOZZA — non pubblicare:</strong> contenuti da completare a cura del consulente privacy.</div>
    <% } %>
    <p class="lbl">Cookie</p>
    <h1 class="st">Cookie Policy</h1>
    <p class="bt" style="margin-top:24px">Il sito utilizza unicamente cookie tecnici strettamente necessari al funzionamento. Nessun cookie di profilazione o marketing.</p>
    <p class="bt" style="margin-top:24px">[DA COMPLETARE]</p>
  </div>
</section>
<%- include('footer.html.tpl', { lawyer, h }) %>
</body>
</html>
