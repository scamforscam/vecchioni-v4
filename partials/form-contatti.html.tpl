<div class="form-card">
  <p class="form-card-title"><%= lawyer.form.title %></p>
  <p style="font-size:13px;color:var(--grey-d);margin-bottom:20px;line-height:1.55"><%= lawyer.form.intro %></p>
  <form id="contact-form" novalidate>
    <% lawyer.form.fields.forEach(f => { %>
      <div class="form-group">
        <label for="<%= f.id %>"><%= f.label %></label>
        <input type="<%= f.type %>" id="<%= f.id %>" placeholder="<%= f.placeholder %>" <% if (f.required) { %>required<% } %>>
      </div>
    <% }); %>
    <button type="submit" class="btn form-submit" style="text-transform:none;letter-spacing:.01em"><%= lawyer.form.ctaText %></button>
  </form>
  <div class="form-success" id="form-success" style="display:none;text-align:center;padding:32px 20px">
    <h3 style="font-size:20px;font-weight:700;color:var(--white);margin-bottom:10px"><%= lawyer.form.successTitle %></h3>
    <p style="font-size:14px;color:var(--grey);line-height:1.7"><%- lawyer.form.successBody %></p>
  </div>
  <p class="form-gdpr"><%- lawyer.form.gdpr %></p>
</div>
