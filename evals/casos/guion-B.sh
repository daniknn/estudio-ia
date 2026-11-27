# Slash /estudio-ia:guion sobre un proyecto con brief y sin guion; no inventa datos ni precios.
SKILL=guion; FIXTURE=espacio; BUDGET=1.5
setup() { :; }
PROMPT="/estudio-ia:guion Para proyectos/reel-cafe, un reel de 30 segundos. Datos reales: doña Lupe lleva 30 años con su puesto de café de olla y usa una olla de barro; no hay más datos, lo que falte márcalo como hueco. Quiero cerrar con un CTA: guardar el reel. Guárdalo en proyectos/reel-cafe/guion.md. $NOTA_A"
check() {
  [ -f "$dir/proyectos/reel-cafe/guion.md" ] || fail "no escribió proyectos/reel-cafe/guion.md"
  r=$($LIB guion "$dir/proyectos/reel-cafe/guion.md" --dur 30) || fail "$r"
  grep -qi 'guard' "$dir/proyectos/reel-cafe/guion.md" || fail "sin CTA de guardar"
  grep -Eqi 'Lupe|olla' "$dir/proyectos/reel-cafe/guion.md" || fail "no usa los datos de la persona"
  pass "guion.md válido (Duración estimada, bloques con tiempo y propósito, gancho primero, CTA, sin precios inventados)"
}
