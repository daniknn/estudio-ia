# Slash: elige estructura y, con el sí dado, escribe `estructura` en el brief sin tocar otros campos.
SKILL=storytelling; FIXTURE=espacio; BUDGET=1.5
setup() { :; }
PROMPT="/estudio-ia:storytelling Para el proyecto proyectos/reel-cafe. Elige tú la estructura que convenga y aplícala. Mis datos para los beats: doña Lupe lleva 30 años con el puesto; usa una olla de barro; el primer sorbo es lo que quiero mostrar. Lo que no sé lo dejo como hueco. Mi sí: escribe el campo estructura en el brief y el esqueleto en el cuerpo, sin tocar los demás campos. $NOTA_A"
check() {
  b=./proyectos/reel-cafe/brief.md
  cambiados | grep -qx "$b" || fail "no modificó el brief de reel-cafe"
  r=$($LIB estructura "$dir/proyectos/reel-cafe/brief.md" --igual-titulo 'El café de doña Lupe' --igual-formato redes \
      --igual-que_debe_lograr 'que quien lo vea guarde el reel y vaya al puesto esa semana') || fail "$r"
  grep -qi 'Lupe' "$dir/proyectos/reel-cafe/brief.md" || fail "el esqueleto no usa el material de la persona"
  pass "escribió estructura y esqueleto en el brief sin tocar los demás campos ($r)"
}
