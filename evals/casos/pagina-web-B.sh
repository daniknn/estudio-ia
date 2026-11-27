# Descubrimiento sin slash pidiendo el HTML: carga pagina-web y escribe web/index.html autocontenido, móvil y accesible.
SKILL=pagina-web; FIXTURE=espacio; BUDGET=2
setup() { cp -R "$HERE/fixtures/extra/v02/proyectos/." "$1/proyectos/"; }
PROMPT="Arma la página de mi portafolio (el brief está en proyectos/web-portafolio) y quiero también el index.html para abrirlo en el navegador. Tengo dos fotos, imagenes/abuela.jpg e imagenes/lupe.jpg. No tengo correo ni enlaces: lo que falte déjalo como hueco. Guarda web.md y web/index.html en esa carpeta. $NOTA_A"
check() {
  skill_cargada pagina-web || fail "no se cargó la skill pagina-web"
  p=$dir/proyectos/web-portafolio
  [ -f "$p/web.md" ] || fail "no escribió web.md"
  [ -f "$p/web/index.html" ] || fail "no escribió web/index.html"
  r=$(python3 -I - "$p/web/index.html" <<'PY'
import re, sys
t = open(sys.argv[1], encoding="utf-8").read()
for m in re.finditer(r"<(link|script|img|source|iframe|video|audio)\b[^>]*>", t, re.I):
    if re.search(r"(src|href|srcset|poster)\s*=\s*[\x22\x27]?\s*(https?:)?//", m.group(0), re.I):
        print("recurso externo: %s" % m.group(0)[:80]); sys.exit()
if re.search(r"@import|url\(\s*[\x22\x27]?\s*(https?:)?//", t, re.I): print("CSS con recurso externo"); sys.exit()
if not re.search(r"<meta[^>]+name=[\x22\x27]viewport", t, re.I): print("sin meta viewport"); sys.exit()
if not re.search(r"<html[^>]+\blang=", t, re.I): print("sin lang en <html>"); sys.exit()
for m in re.finditer(r"<img\b[^>]*>", t, re.I):
    if not re.search(r"\balt\s*=", m.group(0), re.I): print("img sin alt: %s" % m.group(0)[:80]); sys.exit()
print("ok")
PY
)
  [ "$r" = ok ] || fail "$r"
  pass "cargó pagina-web; index.html sin recursos externos, con viewport, lang y alt en cada img"
}
