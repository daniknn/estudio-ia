# Slash sin MCP: arma el prompt del plano P02 con el estilo.md, lo guarda y entrega los parámetros para la web.
SKILL=prompt-video; FIXTURE=espacio; BUDGET=2
setup() { cp "$HERE/fixtures/extra/shotlist.yaml" "$HERE/fixtures/extra/estilo.md" "$1/proyectos/corto-abuela/"; }
PROMPT="/estudio-ia:prompt-video proyectos/corto-abuela. Quiero el prompt del plano P02. No tengo Higgsfield conectado; en la web de Higgsfield veo el modelo \"Seedance 2.0\". Estas son todas mis respuestas: 5 segundos, 720p, relación 16:9, sin audio, modo std; acepto el prompt que armes con mi estilo.md. Escribe el prompt. $NOTA_A"
check() {
  sin_mcp; sin_afirmar_generacion
  f=$dir/proyectos/corto-abuela/prompts/P02-v1.yaml
  [ -f "$f" ] || fail "no escribió prompts/P02-v1.yaml"
  m=$(python3 - "$f" "$dir/proyectos/corto-abuela/shotlist.yaml" <<'PY'
import re, sys, yaml
p = yaml.safe_load(open(sys.argv[1], encoding="utf-8"))
s = yaml.safe_load(open(sys.argv[2], encoding="utf-8"))
plano = [x for x in s["planos"] if x["id"] == "P02"][0]
txt = str(p.get("prompt", "")).lower()
claves = [k for k in ("ámbar", "ocres", "35 mm", "grano", "tierra", "olivo", "amber", "ochre", "grain", "earth", "olive") if k in txt]
if p.get("id") != "P02-v1": print("id distinto del archivo")
elif not re.search(r"seedance", str(p.get("modelo", "")), re.I): print("modelo distinto del que dijo la persona")
elif len(txt) < 40: print("prompt vacío o muy corto")
elif len(claves) < 2: print("el prompt no usa el estilo de estilo.md")
elif not isinstance(p.get("parametros"), dict) or not p["parametros"]: print("faltan parametros")
elif p["parametros"].get("duration") != 5: print("duration distinta de 5")
elif "clip_url" in p or "job_id" in p or isinstance(p.get("costo_creditos"), (int, float)): print("inventó clip_url, costo o job_id")
elif plano.get("estado") != "prompt" or plano.get("prompt_id") != "P02-v1": print("el plano no quedó en estado prompt con prompt_id P02-v1")
else: print("ok")
PY
)
  [ "$m" = ok ] || fail "$m"
  tiene 'web|pega' || fail "no dijo que se pega en la web de Higgsfield"
  pass "P02-v1.yaml con modelo, estilo y parámetros, sin clip ni costo; plano en estado prompt; sin MCP"
}
