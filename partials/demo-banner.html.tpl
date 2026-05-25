<% if (h.isDemo) { %>
<div class="demo-banner" role="region" aria-label="Banner bozza dimostrativa">
  <div style="display:flex;align-items:center;gap:12px;flex:1;min-width:0">
    <span class="demo-banner-tag">Bozza</span>
    <span style="overflow:hidden;text-overflow:ellipsis">
      Anteprima dimostrativa per <b><%= lawyer.studio.name %></b><% if (lawyer.demoMeta.agencyName) { %> — realizzata da <b><%= lawyer.demoMeta.agencyName %></b><% } %>
    </span>
  </div>
  <% if (lawyer.demoMeta.ctaPersonalUrl) { %>
    <a class="demo-banner-cta" href="<%= lawyer.demoMeta.ctaPersonalUrl %>" target="_blank" rel="noopener"><%= lawyer.demoMeta.ctaPersonalLabel || 'Parliamone' %> →</a>
  <% } %>
</div>
<% } %>
