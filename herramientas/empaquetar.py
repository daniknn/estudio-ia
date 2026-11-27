#!/usr/bin/env python3
"""Empaqueta cada skill de estudio-ia en un zip para claude.ai.

Uso: python3 herramientas/empaquetar.py [--skills DIR] [--plugin-json FILE] [--out DIR]

Licencia: MIT. Solo biblioteca estándar.
"""
import argparse
import json
import re
import sys
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
ALLOWED_KEYS = {"name", "description", "license", "compatibility", "metadata"}
ALLOWED_EXT = {".md", ".py", ".yaml", ".txt"}
IGNORED = {".DS_Store"}
FIXED_DATE = (2020, 1, 1, 0, 0, 0)


class SkillError(Exception):
    pass


def split_frontmatter(text):
    lines = text.split("\n")
    if not lines or lines[0].strip() != "---":
        raise SkillError("falta el frontmatter (el archivo debe empezar con ---)")
    for i in range(1, len(lines)):
        if lines[i].strip() == "---":
            return lines[1:i], "\n".join(lines[i + 1:])
    raise SkillError("el frontmatter no cierra con ---")


def parse_frontmatter(fm_lines):
    """Lee claves de primer nivel; los valores multilínea se unen."""
    data = {}
    key = None
    for line in fm_lines:
        m = re.match(r"^([A-Za-z0-9_-]+):\s*(.*)$", line)
        if m and not line.startswith((" ", "\t")):
            key = m.group(1)
            data[key] = m.group(2).strip()
        elif key is not None and line.strip():
            data[key] = (data[key] + " " + line.strip()).strip()
    for k, v in data.items():
        if len(v) >= 2 and v[0] == v[-1] and v[0] in "\"'":
            data[k] = v[1:-1]
    return data


def collect_files(skill_dir):
    files = []
    for p in sorted(skill_dir.rglob("*")):
        if p.is_dir() or p.name in IGNORED:
            continue
        files.append(p)
    return files


def validate(skill_dir):
    name = skill_dir.name
    md = skill_dir / "SKILL.md"
    if not md.is_file():
        raise SkillError("falta SKILL.md")
    fm_lines, body = split_frontmatter(md.read_text(encoding="utf-8"))
    fm = parse_frontmatter(fm_lines)
    extra = sorted(set(fm) - ALLOWED_KEYS)
    if extra:
        raise SkillError(
            "claves de frontmatter no permitidas: %s (permitidas: %s)"
            % (", ".join(extra), ", ".join(sorted(ALLOWED_KEYS)))
        )
    if fm.get("name") != name:
        raise SkillError("name %r no coincide con la carpeta %r" % (fm.get("name"), name))
    if len(name) > 64 or not re.fullmatch(r"[a-z0-9-]+", name):
        raise SkillError("name debe cumplir ^[a-z0-9-]+$ y tener 64 caracteres o menos")
    desc = fm.get("description", "")
    if not desc:
        raise SkillError("falta description")
    if len(desc) > 500:
        raise SkillError("description tiene %d caracteres (máximo 500)" % len(desc))
    if "${" in body:
        raise SkillError("el cuerpo contiene '${' (variables exclusivas de Claude Code)")
    if "!`" in body:
        raise SkillError("el cuerpo contiene '!`' (comandos exclusivos de Claude Code)")
    for p in collect_files(skill_dir):
        if p.suffix not in ALLOWED_EXT:
            raise SkillError(
                "archivo no permitido: %s (solo .md, .py, .yaml, .txt)"
                % p.relative_to(skill_dir)
            )


def read_version(plugin_json):
    try:
        data = json.loads(Path(plugin_json).read_text(encoding="utf-8"))
        return str(data["version"])
    except (OSError, ValueError, KeyError) as e:
        raise SkillError("no pude leer la versión de %s: %s" % (plugin_json, e))


def write_zip(skill_dir, version, out_dir):
    name = skill_dir.name
    out = Path(out_dir) / (name + ".zip")
    entries = {}
    for p in collect_files(skill_dir):
        entries["%s/%s" % (name, p.relative_to(skill_dir).as_posix())] = p.read_bytes()
    entries["%s/VERSION" % name] = (version + "\n").encode("utf-8")
    with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:
        for arc in sorted(entries):
            info = zipfile.ZipInfo(arc, FIXED_DATE)
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = 0o644 << 16
            info.create_system = 3
            z.writestr(info, entries[arc])
    return out


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--skills", default=str(ROOT / "plugins/estudio-ia/skills"))
    ap.add_argument(
        "--plugin-json",
        default=str(ROOT / "plugins/estudio-ia/.claude-plugin/plugin.json"),
    )
    ap.add_argument("--out", default=str(ROOT / "dist/claude-ai"))
    args = ap.parse_args(argv)

    skills = sorted(p for p in Path(args.skills).iterdir() if p.is_dir())
    if not skills:
        print("error: no hay skills en %s" % args.skills, file=sys.stderr)
        return 1
    try:
        version = read_version(args.plugin_json)
    except SkillError as e:
        print("error: %s" % e, file=sys.stderr)
        return 1

    failed = False
    for s in skills:
        try:
            validate(s)
        except SkillError as e:
            print("error en %s: %s" % (s.name, e), file=sys.stderr)
            failed = True
    if failed:
        print("No se generó ningún zip.", file=sys.stderr)
        return 1

    Path(args.out).mkdir(parents=True, exist_ok=True)
    for s in skills:
        print("ok %s" % write_zip(s, version, args.out))
    return 0


if __name__ == "__main__":
    sys.exit(main())
