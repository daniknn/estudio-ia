"""Pruebas de empaquetar.py. Licencia: MIT. Uso: python3 herramientas/test_empaquetar.py"""
import json
import sys
import tempfile
import unittest
import zipfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import empaquetar


def make_skill(root, name, frontmatter=None, body="Cuerpo.\n"):
    d = Path(root) / name
    d.mkdir(parents=True)
    fm = frontmatter if frontmatter is not None else "name: %s\ndescription: Hace algo útil.\nlicense: CC-BY-4.0" % name
    (d / "SKILL.md").write_text("---\n%s\n---\n%s" % (fm, body), encoding="utf-8")
    return d


class EmpaquetarTest(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.root = Path(self.tmp.name)
        self.skills = self.root / "skills"
        self.skills.mkdir()
        self.pj = self.root / "plugin.json"
        self.pj.write_text(json.dumps({"version": "9.9.9"}))
        self.out = self.root / "out"

    def tearDown(self):
        self.tmp.cleanup()

    def run_main(self):
        return empaquetar.main(
            ["--skills", str(self.skills), "--plugin-json", str(self.pj), "--out", str(self.out)]
        )

    def test_skill_buena(self):
        d = make_skill(self.skills, "buena")
        (d / "references").mkdir()
        (d / "references" / "a.md").write_text("x")
        (d / ".DS_Store").write_text("basura")
        self.assertEqual(self.run_main(), 0)
        with zipfile.ZipFile(self.out / "buena.zip") as z:
            self.assertEqual(
                z.namelist(),
                ["buena/SKILL.md", "buena/VERSION", "buena/references/a.md"],
            )
            self.assertEqual(z.read("buena/VERSION"), b"9.9.9\n")
        first = (self.out / "buena.zip").read_bytes()
        self.run_main()
        self.assertEqual(first, (self.out / "buena.zip").read_bytes())

    def test_clave_invalida(self):
        make_skill(self.skills, "mala", "name: mala\ndescription: ok\nallowed-tools: Bash")
        self.assertEqual(self.run_main(), 1)
        self.assertFalse((self.out / "mala.zip").exists())
        with self.assertRaises(empaquetar.SkillError) as cm:
            empaquetar.validate(self.skills / "mala")
        self.assertIn("allowed-tools", str(cm.exception))

    def test_description_larga(self):
        make_skill(self.skills, "larga", "name: larga\ndescription: " + "a" * 501)
        with self.assertRaises(empaquetar.SkillError) as cm:
            empaquetar.validate(self.skills / "larga")
        self.assertIn("501", str(cm.exception))
        self.assertEqual(self.run_main(), 1)

    def test_dos_puntos_sin_comillas(self):
        make_skill(self.skills, "puntos", "name: puntos\ndescription: Arma tu pieza: con gancho\nlicense: CC-BY-4.0")
        with self.assertRaises(empaquetar.SkillError) as cm:
            empaquetar.validate(self.skills / "puntos")
        self.assertIn("sin comillas", str(cm.exception))

    def test_dos_puntos_con_comillas(self):
        make_skill(self.skills, "comillas", 'name: comillas\ndescription: "Arma tu pieza: con gancho"\nlicense: CC-BY-4.0')
        empaquetar.validate(self.skills / "comillas")


if __name__ == "__main__":
    unittest.main()
