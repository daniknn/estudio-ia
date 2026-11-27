# Slash /estudio-ia:inicio en una carpeta vacía: crea perfil.md y la estructura del espacio.
SKILL=inicio; FIXTURE=vacio; BUDGET=1.5
setup() { :; }
PROMPT="/estudio-ia:inicio Me llamo Carlos. Cuento historias de mi barrio en reels y en un pódcast. Mi público son vecinos de Iztapalapa de 25 a 45 años. Mis temas: barrio, comida, historia local. Mis formatos: redes, podcast. Mi voz: cálida, irónica, curiosa. Mis herramientas: CapCut, Higgsfield. Mi tope es de 80 créditos al mes. Crea mi perfil y la estructura de mi espacio. $NOTA_A"
check() {
  r=$($LIB perfil "$dir/perfil.md" --tope 80 --nombre '^Carlos$') || fail "perfil.md: $r"
  grep -Eqi 'redes' "$dir/perfil.md" && grep -Eqi 'podcast' "$dir/perfil.md" || fail "perfil.md no conserva los formatos dichos"
  [ -f "$dir/CLAUDE.md" ] && grep -q 'perfil.md' "$dir/CLAUDE.md" || fail "falta CLAUDE.md con la línea de perfil.md"
  [ -f "$dir/wiki/esquema.md" ] && [ -f "$dir/wiki/indice.md" ] || fail "falta wiki/esquema.md o wiki/indice.md"
  [ "$(grep -Eci 'RAW|ficha|índice|indice|\[\[' "$dir/wiki/esquema.md")" -ge 4 ] || fail "esquema.md sin las 4 reglas"
  [ -d "$dir/wiki/RAW" ] && [ -d "$dir/wiki/conceptos" ] && [ -d "$dir/proyectos" ] || fail "faltan wiki/RAW, wiki/conceptos o proyectos/"
  [ -z "$(ls "$dir/wiki/conceptos")" ] || fail "inventó fichas en wiki/conceptos"
  pass "perfil válido (tope 80, 3 adjetivos de voz), CLAUDE.md y estructura del espacio sin fichas inventadas"
}
