<footer><div class="footer-grid">
  <div>
    <div class="nav-mark" style="width:36px;height:36px;font-size:12px"><%= lawyer.studio.logoMark %></div>
    <div class="footer-brand-name"><%= lawyer.studio.name %></div>
    <p class="footer-brand-desc"><%= lawyer.footer.brandDesc %></p>
  </div>
  <div class="footer-col">
    <p class="footer-col-title">Studio</p>
    <address><%= lawyer.contacts.address.street %><br><%= lawyer.contacts.address.zip %> <%= lawyer.contacts.address.city %><br><br><%= lawyer.credentials.court %></address>
  </div>
  <div class="footer-col">
    <p class="footer-col-title">Contatti</p>
    <p><a href="mailto:<%= lawyer.contacts.email %>"><%= lawyer.contacts.email %></a><% if (lawyer.contacts.emergencyLine) { %><br><br><span style="font-size:11px;color:var(--grey-d)"><%= lawyer.contacts.emergencyLine %></span><% } %></p>
  </div>
</div>
<div class="footer-bottom">
  <p class="footer-legal"><%= lawyer.footer.legalLine %><br>© <%= lawyer.footer.year %> <%= lawyer.studio.name %>. Tutti i diritti riservati.</p>
  <div class="footer-links" style="display:flex;gap:20px">
    <a href="privacy.html" style="font-size:11px;color:var(--grey-d);text-decoration:none">Privacy</a>
    <a href="cookie.html" style="font-size:11px;color:var(--grey-d);text-decoration:none">Cookie</a>
    <a href="note-legali.html" style="font-size:11px;color:var(--grey-d);text-decoration:none">Note legali</a>
  </div>
</div>
</footer>
