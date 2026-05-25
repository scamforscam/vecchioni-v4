<!DOCTYPE html>
<html lang="it">
<head>
<%- include('head.html.tpl', { title: 'Privacy Policy — ' + lawyer.studio.shortName, description: 'Informativa privacy ai sensi del Reg. UE 2016/679 (GDPR)', lawyer, h }) %>
<%- include('styles.html.tpl', { lawyer, h }) %>
</head>
<body>
<%- include('demo-banner.html.tpl', { lawyer, h }) %>
<%- include('nav.html.tpl', { lawyer, h }) %>

<section class="sec" style="padding-top:140px">
  <div class="wrap" style="max-width:780px">
    <% if (lawyer.legal.privacy.draft) { %>
      <div style="background:rgba(220,150,80,.1);border:1px solid rgba(220,150,80,.4);padding:20px;margin-bottom:32px;font-size:13px;color:var(--cream)"><strong style="color:var(--gold)">⚠ BOZZA — non pubblicare:</strong> contenuti da completare a cura del consulente privacy.</div>
    <% } %>
    <p class="lbl">Privacy</p>
    <h1 class="st">Informativa Privacy</h1>
    <p class="bt" style="margin-top:24px">Ai sensi del Reg. UE 2016/679 (GDPR).</p>
    <h3 style="margin-top:32px;color:var(--white)">Titolare del trattamento</h3>
    <p class="bt"><%= lawyer.studio.name %><br><%= lawyer.contacts.address.street %> — <%= lawyer.contacts.address.zip %> <%= lawyer.contacts.address.city %><br>Foro: <%= lawyer.credentials.order %><br>Email: <a href="mailto:<%= lawyer.contacts.email %>" style="color:var(--gold)"><%= lawyer.contacts.email %></a></p>
    <h3 style="margin-top:32px;color:var(--white)">Dati raccolti tramite form</h3>
    <p class="bt">Il form di contatto raccoglie esclusivamente nome e numero di telefono, per ricontatto da parte dello studio.</p>
    <h3 style="margin-top:32px;color:var(--white)">Diritti dell'interessato</h3>
    <p class="bt">Accesso, rettifica, cancellazione, opposizione, portabilità — esercitabili scrivendo a <a href="mailto:<%= lawyer.contacts.email %>" style="color:var(--gold)"><%= lawyer.contacts.email %></a>.</p>
    <p class="bt" style="margin-top:48px;font-size:11px;color:var(--grey-d)">[DA COMPLETARE A CURA DEL CONSULENTE PRIVACY]</p>
  </div>
</section>

<%- include('footer.html.tpl', { lawyer, h }) %>
</body>
</html>
