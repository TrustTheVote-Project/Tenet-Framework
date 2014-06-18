window.blank  = (s) -> !s or s.match(/^\s*$/)
window.filled = (s) -> !blank(s)
window.email  = (s) -> filled(s) and s.match(/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i)
window.url    = (s) -> filled(s) and s.match(/^https?:\/\/[A-Z0-9.-]+\.[A-Z]{2,4}$/i)
window.phone  = (s) -> filled(s) and s.replace(/[^0-9]/g, '').match(/^[0-9]{10}$/)

window.t = (key) -> gon.l[key]
