<nav class="nav" id="nav"><div class="nav-inner">
  <a href="index.html" class="nav-logo"><div class="nav-mark"><%= lawyer.studio.logoMark %></div><div><div class="nav-name"><%= lawyer.studio.shortName %></div><span class="nav-role"><%= lawyer.studio.tagline %></span></div></a>
  <ul class="nav-links"><% lawyer.nav.items.forEach(i => { %><li><a href="<%= i.href %>"><%= i.label %></a></li><% }); %><li><a href="#contatti" class="nav-cta"><%= lawyer.nav.ctaLabel %></a></li></ul>
</div></nav>
