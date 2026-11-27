# Descubrimiento sin slash: "escríbeme el guion de un reel de 30 segundos" carga guion y escribe el archivo.
SKILL=guion; FIXTURE=espacio; BUDGET=1.5
setup() { :; }
PROMPT="Escríbeme el guion de un reel de 30 segundos sobre la regla de los tercios para mis seguidores de fotografía de celular. Efecto que quiero: que quien lo vea encuadre su siguiente foto con el sujeto en una intersección de la cuadrícula. CTA: que guarde el reel. Datos reales que puedes usar: los de mi wiki sobre la regla de los tercios; no agregues datos ni cifras. Guárdalo en proyectos/reel-tercios/guion.md. $NOTA_A"
check() {
  skill_cargada guion || fail "no se cargó la skill guion"
  [ -f "$dir/proyectos/reel-tercios/guion.md" ] || fail "no escribió proyectos/reel-tercios/guion.md"
  r=$($LIB guion "$dir/proyectos/reel-tercios/guion.md" --dur 30) || fail "$r"
  tiene 'guarda|guardar' && grep -qi 'guard' "$dir/proyectos/reel-tercios/guion.md" || fail "el guion no cierra con el CTA pedido (guardar)"
  pass "cargó guion; guion.md con Duración estimada, bloques con tiempo y propósito, gancho primero y CTA"
}
