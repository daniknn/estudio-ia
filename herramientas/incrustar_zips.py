#!/usr/bin/env python3
"""Incrusta los zips de claude.ai en guia/index.html para descargarlos desde el artifact.

El artifact de claude.ai bloquea las ligas externas, así que la guía lleva los
zips en base64 y los entrega con la capacidad `downloads`. En GitHub Pages las
ligas normales siguen funcionando.

Uso: python3 herramientas/incrustar_zips.py [--check]
  --check  falla si los zips incrustados no son los que genera empaquetar.py.

Licencia: MIT. Solo biblioteca estándar.
"""
import base64
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import empaquetar

ROOT = Path(__file__).resolve().parent.parent
GUIA = ROOT / "guia/index.html"
INICIO = '<script type="application/json" id="zips">'
FIN = "</script><!-- zips:fin -->"


def bloque():
    with tempfile.TemporaryDirectory() as tmp:
        if empaquetar.main(["--out", tmp]) != 0:
            raise SystemExit("empaquetar.py falló")
        files = {
            p.stem: base64.b64encode(p.read_bytes()).decode("ascii")
            for p in sorted(Path(tmp).glob("*.zip"))
        }
    version = empaquetar.read_version(ROOT / "plugins/estudio-ia/.claude-plugin/plugin.json")
    return INICIO + json.dumps({"version": version, "files": files}, separators=(",", ":")) + FIN


def main(argv):
    html = GUIA.read_text(encoding="utf-8")
    a = html.find(INICIO)
    b = html.find(FIN)
    if a < 0 or b < 0:
        print("error: faltan los marcadores de zips en guia/index.html", file=sys.stderr)
        return 1
    nuevo = bloque()
    actual = html[a:b + len(FIN)]
    if "--check" in argv:
        if actual != nuevo:
            print("error: los zips de la guía están desactualizados; corre herramientas/incrustar_zips.py", file=sys.stderr)
            return 1
        print("ok zips de la guía al día")
        return 0
    GUIA.write_text(html[:a] + nuevo + html[b + len(FIN):], encoding="utf-8")
    print("ok zips incrustados en %s" % GUIA)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
