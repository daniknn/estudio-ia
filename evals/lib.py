#!/usr/bin/env python3
"""Validaciones deterministas para los evals de estudio-ia.
Uso: python3 -I lib.py <orden> <args...>. Imprime "ok" o la razón del fallo; código 0 si ok.
Licencia MIT."""
import os
import re
import sys

import yaml

FORMATOS = {"video", "redes", "articulo", "web", "podcast"}
CAMPOS_BRIEF = {"titulo", "formato", "idea", "publico", "que_debe_lograr",
                "fuera_de_alcance", "estructura", "presupuesto_creditos"}
CAMPOS_PERFIL = {"nombre", "que_hago", "publico_habitual", "temas", "voz",
                 "formatos", "herramientas", "tope_creditos_mes"}
FALTANTE = re.compile(r"^(|todo|\.\.\.|<.*>)$", re.I)


def fallo(msg):
    print(msg)
    sys.exit(1)


def leer(path):
    try:
        return open(path, encoding="utf-8").read()
    except OSError:
        fallo("no existe %s" % path)


def frontmatter(path):
    t = leer(path)
    m = re.match(r"---\n(.*?)\n---\n?(.*)", t, re.S)
    if not m:
        fallo("%s no tiene frontmatter" % os.path.basename(path))
    d = {}
    for linea in m.group(1).split("\n"):
        if not linea.strip():
            continue
        k, _, v = linea.partition(":")
        d[k.strip()] = v.strip().strip('"').strip("'")
    return d, m.group(2)


def brief(path, o):
    d, _ = frontmatter(path)
    extra = set(d) - CAMPOS_BRIEF
    if extra:
        fallo("campos fuera del esquema: %s" % ",".join(sorted(extra)))
    for k in ("titulo", "formato", "idea", "publico", "que_debe_lograr", "fuera_de_alcance"):
        if k not in d or FALTANTE.match(d[k]):
            fallo("falta o está vacío el campo %s" % k)
    for k, v in d.items():
        if re.search(r"<.+>|\bTODO\b", v):
            fallo("el campo %s tiene un marcador sin llenar: %s" % (k, v))
    if d["formato"] not in FORMATOS:
        fallo("formato inválido: %s" % d["formato"])
    if "formato" in o and d["formato"] != o["formato"]:
        fallo("formato %s, se esperaba %s" % (d["formato"], o["formato"]))
    if "presupuesto" in o:
        if d.get("presupuesto_creditos") != o["presupuesto"]:
            fallo("presupuesto_creditos=%r, se esperaba %s" % (d.get("presupuesto_creditos"), o["presupuesto"]))
    elif "presupuesto_creditos" in d and "sin-presupuesto" in o:
        fallo("inventó presupuesto_creditos=%s" % d["presupuesto_creditos"])
    if "efecto" in o and not re.search(o["efecto"], d["que_debe_lograr"], re.I):
        fallo("que_debe_lograr no conserva lo que dijo la persona: %s" % d["que_debe_lograr"])
    print("ok")


def perfil(path, o):
    d, _ = frontmatter(path)
    extra = set(d) - CAMPOS_PERFIL
    if extra:
        fallo("campos fuera de la tabla: %s" % ",".join(sorted(extra)))
    for k in ("nombre", "que_hago", "publico_habitual", "temas", "voz", "formatos", "herramientas"):
        if k not in d or FALTANTE.match(d[k]):
            fallo("falta o está vacío %s" % k)
    for k, v in d.items():
        if re.search(r"<.+>", v):
            fallo("el campo %s conserva un marcador: %s" % (k, v))
    if not re.fullmatch(r"\d+", d.get("tope_creditos_mes", "")):
        fallo("tope_creditos_mes no es entero: %r" % d.get("tope_creditos_mes"))
    if d["tope_creditos_mes"] != o.get("tope", d["tope_creditos_mes"]):
        fallo("tope_creditos_mes=%s, se esperaba %s" % (d["tope_creditos_mes"], o["tope"]))
    if not re.search(o.get("nombre", "."), d["nombre"], re.I):
        fallo("nombre distinto del que dijo la persona: %s" % d["nombre"])
    if len([x for x in re.split(r"[,;]| y ", d["voz"]) if x.strip()]) != 3:
        fallo("voz no son 3 adjetivos: %s" % d["voz"])
    print("ok")


def guion_bloques(path, o):
    t = leer(path)
    cuerpo = re.sub(r"\A---\n.*?\n---\n", "", t, count=1, flags=re.S)  # frontmatter opcional
    previo = cuerpo.split("\n## ", 1)[0]
    m = re.search(r"^\W*Duración estimada:?\W*\s*(\d+):(\d{2})", previo, re.M)
    if not m:
        fallo("no hay una línea 'Duración estimada: mm:ss' antes del primer bloque")
    dur = int(m.group(1)) * 60 + int(m.group(2))
    objetivo = int(o.get("dur", 30))
    if abs(dur - objetivo) > 5:
        fallo("duración estimada %ds, se pedía %ds" % (dur, objetivo))
    # encabezado `## [mm:ss] Bloque · propósito` (se acepta un rango [mm:ss–mm:ss]: cuenta su inicio)
    bloques = re.findall(r"^## \[(\d+):(\d{2})[^\]]*\]\s*(.+)$", cuerpo, re.M)
    if len(bloques) < 3:
        fallo("hay %d bloques '## [mm:ss] Bloque · propósito' (se esperan 3 o más)" % len(bloques))
    ts = [int(a) * 60 + int(b) for a, b, _ in bloques]
    if ts[0] != 0:
        fallo("el primer bloque (gancho) no empieza en 00:00")
    if ts != sorted(ts) or len(set(ts)) != len(ts):
        fallo("los tiempos de los bloques no son crecientes: %s" % ts)
    if ts[-1] >= objetivo + 5:
        fallo("el último bloque empieza en %ds, fuera de la duración" % ts[-1])
    for _, _, resto in bloques:
        if not re.search(r"[·—–]| - ", resto):
            fallo("un bloque no declara propósito en su encabezado: %s" % resto)
    if not re.search(r"gancho|hook", bloques[0][2], re.I):
        fallo("el primer bloque no se rotula como gancho: %s" % bloques[0][2])
    if re.search(r"\$\s?\d|\d+\s?pesos|\bMXN\b", cuerpo):
        fallo("inventó un precio")
    print("ok")


def shotlist(proy, o):
    path = os.path.join(proy, "shotlist.yaml")
    try:
        d = yaml.safe_load(leer(path))
    except yaml.YAMLError as e:
        fallo("YAML inválido: %s" % str(e).split("\n")[0])
    if not isinstance(d, dict) or not isinstance(d.get("planos"), list) or not d["planos"]:
        fallo("no hay lista 'planos'")
    g = leer(os.path.join(proy, "guion.md"))
    escenas = [int(x) for x in re.findall(r"^## ESC (\d+)\b", g, re.M)]
    ids, cubiertas = set(), set()
    for p in d["planos"]:
        if not isinstance(p, dict):
            fallo("un plano no es un mapa")
        if not re.fullmatch(r"P\d{2}", str(p.get("id", ""))) or p["id"] in ids:
            fallo("id inválido o repetido: %r" % p.get("id"))
        ids.add(p["id"])
        if p.get("escena") not in escenas:
            fallo("%s apunta a una escena que no existe: %r" % (p["id"], p.get("escena")))
        cubiertas.add(p["escena"])
        for k in ("proposito", "descripcion", "camara", "modelo"):
            if not str(p.get(k, "")).strip():
                fallo("%s sin %s" % (p["id"], k))
        if not isinstance(p.get("duracion_s"), (int, float)) or p["duracion_s"] <= 0:
            fallo("%s con duracion_s inválida: %r" % (p["id"], p.get("duracion_s")))
        if p.get("estado") != "idea":
            fallo("%s con estado %r (los nuevos van en idea)" % (p["id"], p.get("estado")))
        if "prompt_id" in p or "clip_url" in p:
            fallo("%s trae prompt_id o clip_url" % p["id"])
        if not re.search(o["modelo"], str(p["modelo"]), re.I):
            fallo("%s con modelo %r, la persona dijo /%s/" % (p["id"], p["modelo"], o["modelo"]))
    if set(escenas) - cubiertas:
        fallo("escenas sin plano: %s" % sorted(set(escenas) - cubiertas))
    print("ok %d planos" % len(d["planos"]))


def ficha(path, o):
    t = leer(path)
    if not re.match(r"# \S", t):
        fallo("la ficha no empieza con '# Concepto'")
    m = re.search(r"^Idea:\s*(.+?)(?=^\w+:|\Z)", t, re.M | re.S)
    if not m or len(m.group(1).strip()) < 20:
        fallo("sin Idea")
    if len([x for x in m.group(1).strip().split("\n") if x.strip()]) > 5:
        fallo("la Idea pasa de 4 a 5 líneas")
    f = re.search(r"^Fuente:\s*(.+)$", t, re.M)
    if not f:
        fallo("sin línea Fuente:")
    if not re.search(o["fuente"], f.group(1)):
        fallo("Fuente inesperada: %s" % f.group(1))
    base = os.path.dirname(path)
    r = re.search(r"^Relacionado:\s*(.+)$", t, re.M)
    if r:
        for s in re.findall(r"\[\[([^\]]+)\]\]", r.group(1)):
            if not os.path.exists(os.path.join(base, s + ".md")) and s != os.path.basename(path)[:-3]:
                fallo("Relacionado apunta a [[%s]], que no existe" % s)
    print("ok")


def pasos_estructura(path, o):
    d, cuerpo = frontmatter(path)
    for k, v in o.items():
        if k.startswith("igual-") and d.get(k[6:]) != v:
            fallo("cambió o perdió el campo %s (%r)" % (k[6:], d.get(k[6:])))
    if FALTANTE.match(d.get("estructura", "")):
        fallo("no escribió el campo estructura")
    if len(cuerpo.strip()) < 80:
        fallo("el cuerpo no trae el esqueleto")
    print("ok estructura=%s" % d["estructura"])


if __name__ == "__main__":
    orden, args = sys.argv[1], sys.argv[2:]
    pos = [a for a in args if not a.startswith("--")]
    o = {}
    i = 0
    while i < len(args):
        if args[i].startswith("--"):
            if i + 1 < len(args) and not args[i + 1].startswith("--"):
                o[args[i][2:]] = args[i + 1]
                i += 2
            else:
                o[args[i][2:]] = True
                i += 1
        else:
            i += 1
    pos = [a for a in pos if a not in o.values()]
    {"brief": brief, "perfil": perfil, "guion": guion_bloques, "shotlist": shotlist,
     "ficha": ficha, "estructura": pasos_estructura}[orden](pos[0], o)
