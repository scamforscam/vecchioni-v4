<!DOCTYPE html>
<html lang="it">
<head>
<%- include('head.html.tpl', { title: 'Note Legali — ' + lawyer.studio.shortName, description: 'Note legali', lawyer, h }) %>
<%- include('styles.html.tpl', { lawyer, h }) %>
</head>
<body>
<%- include('demo-banner.html.tpl', { lawyer, h }) %>
<%- include('nav.html.tpl', { lawyer, h }) %>
<section class="sec" style="padding-top:140px">
  <div class="wrap" style="max-width:780px">
    <% if (lawyer.legal.noteLegali.draft) { %>
      <div style="background:rgba(220,150,80,.1);border:1px solid rgba(220,150,80,.4);padding:20px;margin-bottom:32px;font-size:13px;color:var(--cream)"><strong style="color:var(--gold)">⚠ BOZZA — non pubblicare:</strong> contenuti da completare.</div>
    <% } %>
    <p class="lbl">Note legali</p>
    <h1 class="st">Note Legali</h1>
    <p class="bt" style="margin-top:24px">Studio: <%= lawyer.studio.name %><br>Sede: <%= lawyer.contacts.address.street %>, <%= lawyer.contacts.address.zip %> <%= lawyer.contacts.address.city %><br>Iscritto a: <%= lawyer.credentials.order %><br>Email: <%= lawyer.contacts.email %></p>
    <p class="bt" style="margin-top:48px;font-size:11px;color:var(--grey-d)">[DA COMPLETARE]</p>
  </div>
</section>
<%- include('footer.html.tpl', { lawyer, h }) %>
</body>
</html>
