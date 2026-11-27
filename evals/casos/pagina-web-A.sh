# Slash: escribe web.md (secciones, CTA, alt, SEO) sin index.html si no lo pidieron; sin correo ni enlaces inventados.
SKILL=pagina-web; FIXTURE=espacio; BUDGET=1.5
setup() { cp -R "$HERE/fixtures/extra/v02/proyectos/." "$1/proyectos/"; }
PROMPT="/estudio-ia:pagina-web proyectos/web-portafolio. Mis dos trabajos están en el brief; tengo dos fotos, imagenes/abuela.jpg e imagenes/lupe.jpg. No tengo correo ni enlaces todavía: lo que falte márcalo como hueco. Guárdalo en proyectos/web-portafolio/web.md. $NOTA_A"
check() {
  f=$dir/proyectos/web-portafolio/web.md
  [ -f "$f" ] || fail "no escribió proyectos/web-portafolio/web.md"
  [ -z "$(nuevos | grep -E 'index\.html$')" ] || fail "escribió un index.html que nadie pidió"
  grep -Eq '^## Objetivo' "$f" || fail "sin ## Objetivo"
  [ "$(grep -Ec '^###? ?[0-9]+\.' "$f")" -ge 3 ] || fail "menos de 3 secciones numeradas"
  grep -Eqi '^## Llamada a la acción' "$f" || fail "sin ## Llamada a la acción"
  grep -Eqi '^## Accesibilidad' "$f" || fail "sin ## Accesibilidad"
  grep -Eqi '^## SEO' "$f" || fail "sin ## SEO"
  grep -Eqi 'alt|texto alternativo' "$f" || fail "sin textos alternativos"
  grep -Eq '[[:alnum:]._-]+@[[:alnum:]-]+\.[a-z]{2,}' "$f" && fail "inventó un correo"
  grep -Eq 'https?://' "$f" && fail "inventó un enlace"
  pass "web.md con objetivo, secciones, CTA, accesibilidad, SEO y alt; sin index.html, correo ni enlaces inventados"
}
