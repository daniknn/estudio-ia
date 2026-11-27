# Slash: guion por escenas -> shotlist.yaml válido con propósito por plano y el modelo que dijo la persona.
SKILL=guion-a-shotlist; FIXTURE=espacio; BUDGET=2
setup() { :; }
PROMPT="/estudio-ia:guion-a-shotlist proyectos/corto-abuela. El brief y el guion ya están en la carpeta. Estas son todas mis respuestas: acepto cada plano que me propongas, no quiero planos de apoyo extra y el modelo de video es Seedance 2.0 en todos. Escribe el shotlist. $NOTA_A"
check() {
  [ -f "$dir/proyectos/corto-abuela/shotlist.yaml" ] || fail "no escribió proyectos/corto-abuela/shotlist.yaml"
  r=$($LIB shotlist "$dir/proyectos/corto-abuela" --modelo seedance) || fail "$r"
  cambiados | grep -q 'corto-abuela/guion.md' && fail "modificó el guion existente"
  pass "shotlist.yaml válido con propósito por plano, cada escena cubierta y modelo Seedance ($r)"
}
