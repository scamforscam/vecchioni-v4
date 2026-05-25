<!DOCTYPE html>
<html lang="it">
<head>
<%- include('head.html.tpl', { title: area.title + ' — ' + lawyer.studio.shortName, description: area.hero.subtitle, lawyer, h }) %>
<%- include('styles.html.tpl', { lawyer, h }) %>
</head>
<body>
<%- include('demo-banner.html.tpl', { lawyer, h }) %>
<%- include('nav.html.tpl', { lawyer, h }) %>

<!-- PDP HERO -->
<div style="padding:160px clamp(20px,5vw,80px) 120px;position:relative;overflow:hidden;background:var(--black);background-image:linear-gradient(rgba(10,10,10,.72),rgba(10,10,10,.9))<% if (area.hero.image) { %>,url('<%= area.hero.image %>')<% } %>;background-size:cover;background-position:center;padding-top:<%= h.isDemo ? '160px' : '160px' %>">
  <div style="max-width:1200px;margin:0 auto;position:relative;z-index:1">
    <p style="font-size:13px;color:var(--grey-d);margin-bottom:28px"><a href="index.html" style="color:var(--grey-d);text-decoration:none">Home</a> <span style="margin:0 8px;color:var(--border)">›</span> <%= area.title %></p>
    <div class="hero-badge">● <%= area.hero.badge %></div>
    <h1 style="font-size:clamp(2.4rem,5vw,4rem);font-weight:800;line-height:1.08;color:var(--white);max-width:820px;margin-bottom:24px"><%= area.hero.h1Line1 %><br><%= area.hero.h1Line2 %></h1>
    <p style="font-size:clamp(.95rem,1.8vw,1.1rem);color:var(--grey);max-width:640px;margin-bottom:44px;line-height:1.7"><%= area.hero.subtitle %></p>
    <a href="#contatti" class="btn"><%= lawyer.hero.ctaText %></a>
    <p class="microcopy"><%= lawyer.hero.microcopy %></p>
  </div>
</div>

<!-- CRED BAR -->
<div class="cred-bar"><div class="cred-inner">
  <% lawyer.credentials.credBar.forEach(c => { %>
    <div class="cred-item"><div class="cred-num"><%= c.num %></div><div class="cred-lbl"><%= c.label %></div></div>
  <% }); %>
</div></div>

<!-- IL PROBLEMA -->
<section class="sec" style="background:var(--anthracite)">
  <div class="wrap" style="display:grid;grid-template-columns:1fr 1.4fr;gap:64px;align-items:center">
    <div><p class="lbl">Il problema</p><h2 class="st">La situazione<br>in cui ti trovi.</h2><div style="width:48px;height:2px;background:var(--gold);margin-top:24px"></div></div>
    <div><p class="bt" style="margin-bottom:20px"><%= area.problemText %></p></div>
  </div>
</section>

<!-- L'APPROCCIO -->
<% if (area.approach) { %>
<section class="sec" style="background:var(--black)">
  <div class="wrap">
    <p class="lbl">L'approccio difensivo</p>
    <h2 class="st"><%= area.approach.h2White %> <em><%= area.approach.h2Gold %></em></h2>
    <p class="bt"><%= area.approach.intro %></p>
    <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:24px;margin-top:48px">
      <% area.approach.cards.forEach(c => { %>
        <div style="background:#141414;border:1px solid #2A2A2A;padding:40px 32px;position:relative;border-top:2px solid var(--gold)">
          <div style="font-size:10px;font-weight:700;letter-spacing:.12em;color:var(--gold);margin-bottom:16px;text-transform:uppercase"><%= c.label %></div>
          <div style="font-size:1.3rem;font-weight:700;color:var(--white);margin-bottom:14px;line-height:1.3"><%= c.title %></div>
          <p style="font-size:14px;color:var(--grey);line-height:1.65"><%= c.desc %></p>
        </div>
      <% }); %>
    </div>
  </div>
</section>
<% } %>

<!-- COME SI IMPOSTA LA DIFESA -->
<% if (area.method) { %>
<section class="sec" style="background:var(--anthracite)">
  <div class="wrap">
    <p class="lbl"><%= area.method.label %></p>
    <h2 class="st" style="margin-bottom:32px"><%= area.method.h2White %><br><em><%= area.method.h2Gold %></em></h2>
    <p class="bt" style="max-width:740px;color:var(--white);margin-bottom:48px"><%= area.method.subtitle %></p>
    <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:24px">
      <% area.method.steps.forEach(s => { %>
        <div>
          <div style="font-size:clamp(1.8rem,3vw,2.4rem);font-weight:800;color:var(--gold);margin-bottom:16px;line-height:1"><%= s.num %></div>
          <div style="font-size:1.1rem;font-weight:700;color:var(--white);margin-bottom:10px"><%= s.title %></div>
          <p style="font-size:14px;color:var(--grey);line-height:1.65"><%= s.desc %></p>
        </div>
      <% }); %>
    </div>
  </div>
</section>
<% } %>

<!-- OBIEZIONI / FAQ AREA -->
<% if (area.faq) { %>
<section class="sec" style="background:var(--black)">
  <div class="wrap">
    <p class="lbl"><%= area.faq.label %></p>
    <h2 class="st" style="margin-bottom:44px"><%= area.faq.h2White %><br><em><%= area.faq.h2Gold %></em></h2>
    <div style="border:1px solid var(--border)">
      <% area.faq.items.forEach(item => { %>
        <details style="border-bottom:1px solid var(--border)">
          <summary style="cursor:pointer;padding:28px 32px;font-size:clamp(.95rem,2vw,1.1rem);font-weight:700;color:var(--white);list-style:none"><%- item.q %></summary>
          <div style="padding:0 32px 28px;font-size:1rem;color:var(--grey);line-height:1.75;max-width:780px"><%- item.a %></div>
        </details>
      <% }); %>
    </div>
  </div>
</section>
<% } %>

<!-- CONTATTI -->
<section class="sec" id="contatti" style="background:var(--anthracite)">
  <div class="wrap" style="display:grid;grid-template-columns:1fr 1fr;gap:80px;align-items:flex-start">
    <div>
      <p class="lbl"><%= lawyer.contattiSection.label %></p>
      <h2 class="st"><%= lawyer.contattiSection.h2White %><br><em><%= lawyer.contattiSection.h2Gold %></em></h2>
      <% if (area.ctaUrgency) { %>
        <div style="border-left:2px solid var(--gold);padding:14px 20px;background:var(--gold-dim);font-size:1rem;color:var(--white);font-weight:600;line-height:1.5;margin:20px 0 28px"><%= area.ctaUrgency %></div>
      <% } %>
      <div style="display:flex;flex-direction:column;gap:14px;margin-top:24px">
        <% lawyer.contattiSection.trustList.forEach(t => { %>
          <div style="display:flex;align-items:center;gap:12px;font-size:14px;color:var(--grey)"><div style="width:6px;height:6px;background:var(--gold);flex-shrink:0"></div><%= t %></div>
        <% }); %>
      </div>
    </div>
    <%- include('form-contatti.html.tpl', { lawyer, h }) %>
  </div>
</section>

<!-- CROSS-GRID -->
<section class="sec" style="background:var(--anthracite);padding-top:72px;padding-bottom:72px">
  <div class="wrap">
    <p class="lbl">Difendo anche in:</p>
    <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:12px;margin-top:36px">
      <% lawyer.areas.items.filter(a => a.hasDetailPage && a.slug !== area.slug).slice(0,2).forEach(a => { %>
        <a href="<%= a.slug %>.html" style="display:flex;align-items:center;gap:14px;background:var(--anthracite);border:1px solid var(--border);padding:20px 22px;text-decoration:none;color:var(--white);transition:border-color .25s">
          <div><div style="font-size:14px;font-weight:600;color:var(--white)"><%= a.title %></div><div style="font-size:12px;color:var(--grey-d);margin-top:3px"><%= a.subtitle || a.cardDesc.substring(0,40) %></div></div>
        </a>
      <% }); %>
    </div>
  </div>
</section>

<%- include('footer.html.tpl', { lawyer, h }) %>
</body>
</html>
