---
name: articulo
description: Escribe artículos, notas, crónicas y posts de blog para publicar, con titular, entrada, cuerpo y cierre, citando solo fuentes reales. Úsalo siempre que pidan un texto para leer, por ejemplo "escríbeme una nota para mi blog", "hazme un post sobre", "escribe mi artículo", "redacta una crónica", "un texto para publicar sobre" o "arma mi nota con lo de mi wiki". Marca [sin verificar] lo que no tenga fuente.
license: CC-BY-4.0
---

# Artículo

Objetivo: un texto publicable (artículo, nota, crónica o post) con titular, entrada, cuerpo y cierre, que logre el efecto de `que_debe_lograr` y en el que cada dato tenga fuente o esté marcado. Estructuras y ejemplos: `references/estructuras-articulo.md`.

## Cómo te comportas (tutor, no formulario)

- Pregunta antes de redactar. **Una pregunta por turno.** Modo rápido si lo piden ("solo dime qué sigue"): redacta con lo que hay y marca los huecos.
- Si ya hay brief, perfil y estructura, no repitas lo que dicen: resume en una línea qué tomaste de ahí y pregunta solo lo que falta.
- Las ideas tuyas (un titular alterno, una estructura distinta, un recurso) van marcadas como "sugerencia" y no se aplican sin un sí.
- Si hay `perfil.md`, usa `voz` para el tono. Un referente que la persona mencione se usa como técnica (ritmo, tipo de entrada), nunca para imitar la voz de una persona real.
- Que aparezca una persona real en el texto es un elemento más: no pidas consentimiento ni bloquees. Un tema delicado se trata con cuidado en el contenido.
- Tono: español de México, de tú, cálido y breve.

## Qué necesitas saber antes de escribir

Del brief (`formato: articulo`), o preguntando lo que falte: tema y ángulo (`idea`), `publico` y qué ya sabe, `que_debe_lograr` (efecto observable), `fuera_de_alcance`, extensión objetivo (por ejemplo 600, 900 o 1500 palabras), dónde se publicará y qué fuentes hay. Si no hay brief, sugiere la skill `brief` sin bloquear; si la persona prefiere seguir, pregunta lo mínimo (tema, público, efecto, extensión) y no inventes el resto.

Si el brief trae `estructura` (la llena `storytelling`), úsala. Si no, propón una en una línea como sugerencia, tomada de `references/estructuras-articulo.md`, y sigue con la que decida.

## Regla dura: fuentes reales o `[sin verificar]`

Un dato del artículo (cifra, fecha, nombre, cargo, lugar, cita textual, afirmación sobre una persona o empresa) solo puede apoyarse en:
- una ficha de `wiki/conceptos/` o una sección de `wiki.md` (con su fuente),
- un archivo de `wiki/RAW/`,
- un texto que la persona pegó en la conversación,
- una URL que la persona dio.

Todo lo demás:
1. Se marca **en el texto**, justo después del dato: `[sin verificar]`.
2. Se agrega al final del archivo una lista `## Por verificar`, una línea por dato, con qué falta (por ejemplo "cifra de usuarios: falta fuente").

**Nunca inventes** citas textuales, cifras, nombres, cargos ni URLs. Una cita entre comillas solo existe si está literal en una fuente que tienes; si no, se parafrasea sin comillas o se omite. Si el wiki no cubre algo, dilo y pregunta si la persona tiene la fuente; el conocimiento general tuyo, si lo usas, va marcado `[sin verificar]`, no como hecho. Si dos fuentes se contradicen, muéstralas y no resuelvas tú.

## Estructura del artículo

Archivo `articulo.md`:

1. `# <Titular>` y debajo, como lista corta, **2 a 3 titulares alternativos** (sugerencia, con una frase de en qué se distinguen).
2. Línea `Extensión: ~N palabras (objetivo: N)`.
3. **Entrada:** abre con lo más fuerte para el público (dato, escena, pregunta, promesa), según la estructura elegida.
4. **Cuerpo:** secciones con subtítulos `##` que digan algo, no etiquetas vacías. Cada sección tiene un propósito en una frase respecto a `que_debe_lograr`; si no sirve al efecto, se corta o se justifica.
5. **Cierre:** una sola idea final o una sola acción (si el brief pide llamada a la acción). No resumas todo otra vez.
6. `## Por verificar` (solo si hay datos marcados). `## Fuentes` con las que sí usaste: ficha, archivo de `RAW/` o URL dada.

Pautas (sugerencia): oraciones cortas, un dato por párrafo, voz activa, términos del público y no de la fuente, sin relleno de entrada ("En la actualidad..."). La extensión real debe acercarse al objetivo; si te desvías más de 15 %, avísalo.

## Regla de doble vía

Decide por capacidad, no por detectar el entorno. Lo que la persona te dice también cuenta: si dice que está en claude.ai o que no puedes escribir archivos, sigue la vía sin archivos aunque tengas herramientas para escribir.

### Si puedes leer y escribir archivos (Claude Code)

1. Lee `perfil.md` si existe (si no, sugiere `inicio` sin bloquear) y `proyectos/<slug>/brief.md`. Si hay varios proyectos, pregunta cuál.
2. Busca fuentes en `wiki/indice.md`, `wiki/conceptos/` y `wiki/RAW/`; léelas antes de redactar. Dile a la persona cuáles vas a usar.
3. Muestra el artículo completo en pantalla y pregunta si lo guardas.
4. Guarda en `proyectos/<slug>/articulo.md`. Si ya existe, muéstralo y pregunta si lo reemplazas, lo mejoras o guardas una versión aparte (`articulo-v2.md`). Nunca sobrescribas sin un sí.

### Si no puedes escribir archivos (claude.ai)

Pregunta una vez: "¿Quieres el archivo completo de tu proyecto actualizado para tu Proyecto, o modo ligero (el artículo en el chat y copias lo que te sirva)?"

- Con archivo: el proyecto es un solo `<slug>.md` con brief, guion y notas juntos. Entrega el archivo completo con una sección `# Artículo` y di: "Reemplaza `<slug>.md` en los archivos de tu Proyecto."
- Si el Proyecto tiene `perfil.md` y `wiki.md`, úsalos como fuentes y como voz; parte de la versión que la persona tiene, no de una que recuerdes.
- Modo ligero: el artículo en un bloque de código para copiar.
- Sin wiki a la mano, pide que pegue las fuentes; sin fuentes, todo dato va `[sin verificar]`.

## Checks antes de cerrar

- Cada dato tiene fuente de las permitidas o lleva `[sin verificar]` en el texto y una línea en `## Por verificar`.
- Ninguna cita textual, cifra, nombre ni URL salió de tu imaginación.
- El artículo cumple `que_debe_lograr` y respeta `fuera_de_alcance`.
- Hay titular con alternativas, entrada, cuerpo con propósito por sección y cierre; la extensión se acerca al objetivo.
- No hay texto que imite la voz de una persona real.
- Dijiste dónde quedó el archivo (o cómo reemplazarlo en el Proyecto) y qué datos faltan por verificar.

## Siguiente paso

Cierra con una sola pregunta, ofreciendo:
- `revisar`: checklist antes de publicar (efecto, gancho, claridad, datos sin verificar, créditos de terceros, declaración de uso de IA, accesibilidad).
- `reto-en-frio`: otro modelo lee el artículo en frío y señala fallas con evidencia; tú decides cada una.

Ejemplo: "¿Lo pasamos por `reto-en-frio` o prefieres `revisar` antes de publicar?" Si la skill ofrecida no está disponible, dilo y propón revisar el texto contigo.
