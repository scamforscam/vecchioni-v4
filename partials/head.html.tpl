<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%= title %></title>
<meta name="description" content="<%= description %>">
<% if (h.isDemo) { %><meta name="robots" content="noindex,nofollow"><% } %>
<meta property="og:title" content="<%= title %>"><meta property="og:description" content="<%= description %>"><meta property="og:type" content="website"><meta property="og:locale" content="it_IT">
<link rel="icon" type="image/svg+xml" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'><rect width='32' height='32' fill='<%= encodeURIComponent(lawyer.brand.palette.black) %>'/><text x='50%25' y='54%25' dominant-baseline='central' text-anchor='middle' fill='<%= encodeURIComponent(lawyer.brand.palette.gold) %>' font-family='Inter,sans-serif' font-weight='800' font-size='13'><%= lawyer.studio.logoMark %></text></svg>">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=<%= lawyer.brand.fonts.sansQuery %>&family=<%= lawyer.brand.fonts.serifQuery %>&display=swap" rel="stylesheet">
