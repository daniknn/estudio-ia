# estudio-ia

Un ecosistema público y autónomo para crear contenidos con IA (video, redes, artículos, web y podcast). Lo instalas tú, sin depender de nadie.
Te da skills con buenas prácticas, un perfil tuyo, un wiki de lo que aprendes y proyectos ordenados (brief, guion, shotlist y prompts de video).
Funciona en Claude Code (la vía completa) y en claude.ai (la vía ligera con un Proyecto).

**Guía de instalación paso a paso:** https://claude.ai/artifact/7VTeQ2R1D9jZNvxo681bMX (copia en https://daniknn.github.io/estudio-ia/)

## Las 13 skills

En Claude Code se invocan como `/estudio-ia:<skill>`. En claude.ai se activan solas según lo que pidas.

| Skill | Qué hace |
|---|---|
| `inicio` | Primera vez: una entrevista corta y crea tu perfil y la estructura de tu espacio |
| `wiki` | Ingiere fuentes, crea fichas de conceptos con su fuente, mantiene el índice y responde citando el wiki |
| `brief` | Brief de una pieza en cualquier formato: qué debe lograr en el público, para quién y qué queda fuera |
| `storytelling` | Elige y aplica una estructura narrativa según el formato y el efecto que buscas |
| `guion` | Guion para video, reel, short, YouTube, anuncio o podcast, con gancho y cierre |
| `reto-en-frio` | Otro modelo lee tu pieza en frío e intenta romperla; tú decides cada hallazgo |
| `guion-a-shotlist` | Convierte un guion por escenas en un shotlist con propósito por plano |
| `prompt-video` | Convierte un plano en un prompt de video; Higgsfield es opcional, con cotización y tu "sí" |
| `articulo` | Artículo, nota, crónica o post con titular, entrada, cuerpo y cierre; cita solo fuentes reales y marca `[sin verificar]` lo demás |
| `pagina-web` | Página sencilla (landing, portafolio o proyecto) con secciones, textos y llamada a la acción; el `index.html` solo si lo pides |
| `podcast` | Escaleta por bloques con gancho primero, diseño sonoro con licencias y notas del episodio |
| `aprendizaje` | Al cerrar una pieza o un intento, guarda lo que aprendiste y pasa lo útil al wiki; nunca inventa lecciones |
| `revisar` | Lista de verificación antes de publicar, con hallazgos y evidencia; tú decides cada punto |

**Novedades de v0.2:** cinco skills nuevas (`articulo`, `pagina-web`, `podcast`, `aprendizaje` y `revisar`), de 8 a 13 en total.

## Instalar en Claude Code

```
/plugin marketplace add daniknn/estudio-ia
/plugin install estudio-ia@estudio-ia-daniknn
```

La primera vez, actualiza Claude Code con `claude update` para tener la versión más reciente.

## Instalar en claude.ai

1. En la [última Release](https://github.com/daniknn/estudio-ia/releases/latest), sección **Assets**, descarga los `.zip` con nombre de skill (`inicio.zip`, `brief.zip`, `guion.zip`…). No los de **Source code**, y no los descomprimas.
2. En claude.ai ve a Customize, luego Skills, y usa Upload. Sube un zip a la vez.
3. Activa la ejecución de código en tus ajustes.
4. Crea un Proyecto llamado "Mi estudio", abre un chat dentro y escribe "quiero empezar". `inicio` te entrega tu perfil, tu wiki y las instrucciones del Proyecto.

Pasos detallados y advertencias en [docs/instalar.md](docs/instalar.md).

## Primeros pasos

En Claude Code, abre una carpeta nueva y escribe `/estudio-ia:inicio`. En claude.ai, abre tu Proyecto y escribe "quiero empezar". Te hace unas preguntas, una por turno, y deja listo tu perfil.

## Documentación

- [Instalar](docs/instalar.md)
- [Cómo funciona](docs/como-funciona.md)
- [Buenas prácticas por formato](docs/buenas-practicas.md)
- [Créditos](docs/creditos.md)
- [Qué no subir](docs/que-no-subir.md)
- [Actualizar](docs/actualizar.md)

## Licencias

- Código (`hooks/`, `scripts/`, `herramientas/`, `evals/`): [MIT](LICENSE).
- Contenido (`SKILL.md`, `references/`, `docs/`, `espacio/`, `claude-ai/`, `ejemplos/`, `guia/`): [CC BY 4.0](LICENSE-docs).

## Autoría

Creado por Daria Nikitina.
