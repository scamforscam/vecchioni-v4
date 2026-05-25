<%
// Mapping icone Feather/Lucide. Args: name (obbligatorio), size (default 20), stroke (default 1.8).
const _size = typeof size !== 'undefined' ? size : 20;
const _stroke = typeof stroke !== 'undefined' ? stroke : 1.8;
const _open = `<svg width="${_size}" height="${_size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="${_stroke}" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">`;
const _close = `</svg>`;
const _icons = {
  'user':         '<path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/>',
  'users':        '<path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><path d="M23 21v-2a4 4 0 00-3-3.87"/><path d="M16 3.13a4 4 0 010 7.75"/><circle cx="9" cy="7" r="4"/>',
  'package':      '<path d="M16.5 9.4 7.55 4.24"/><path d="M21 16V8a2 2 0 00-1-1.73l-7-4a2 2 0 00-2 0l-7 4A2 2 0 003 8v8a2 2 0 001 1.73l7 4a2 2 0 002 0l7-4A2 2 0 0021 16z"/><polyline points="3.27 6.96 12 12.01 20.73 6.96"/><line x1="12" x2="12" y1="22.08" y2="12"/>',
  'pill':         '<path d="m10.5 20.5 10-10a4.95 4.95 0 1 0-7-7l-10 10a4.95 4.95 0 1 0 7 7Z"/><path d="m8.5 8.5 7 7"/>',
  'car-front':    '<path d="m21 8-2 2-1.5-3.7A2 2 0 0 0 15.66 5H8.34a2 2 0 0 0-1.84 1.3L5 10 3 8"/><path d="M7 14h.01"/><path d="M17 14h.01"/><rect width="18" height="8" x="3" y="10" rx="2"/><path d="M5 18v2"/><path d="M19 18v2"/>',
  'message-square':'<path d="M21 15a2 2 0 01-2 2H7l-4 4V5a2 2 0 012-2h14a2 2 0 012 2z"/>',
  'clock':        '<circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/>',
  'shield':       '<path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>',
  'shield-check': '<path d="M20 13c0 5-3.5 7.5-7.66 8.95a1 1 0 01-.67-.01C7.5 20.5 4 18 4 13V6a1 1 0 011-1c2 0 4.5-1.2 6.24-2.72a1.17 1.17 0 011.52 0C14.51 3.81 17 5 19 5a1 1 0 011 1z"/><path d="m9 12 2 2 4-4"/>',
  'landmark':     '<line x1="3" x2="21" y1="22" y2="22"/><line x1="6" x2="6" y1="18" y2="11"/><line x1="10" x2="10" y1="18" y2="11"/><line x1="14" x2="14" y1="18" y2="11"/><line x1="18" x2="18" y1="18" y2="11"/><polygon points="12 2 20 7 4 7"/>',
  'lock':         '<rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/>',
  'eye':          '<path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/><circle cx="12" cy="12" r="3"/>',
  'briefcase':    '<rect x="2" y="7" width="20" height="14" rx="2"/><path d="M16 21V5a2 2 0 00-2-2h-4a2 2 0 00-2 2v16"/>',
  'send':         '<line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/>',
  'arrow-right':  '<line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/>'
};
%><%- _open + (_icons[name] || _icons['arrow-right']) + _close %>
