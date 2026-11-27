---
name: guion-a-shotlist
description: Convierte un guion por escenas en un shotlist con propósito por plano, y ayuda a escribir el guion si aún no existe. Úsalo cuando digas "pasa mi guion a shotlist", "arma el shotlist", "qué planos necesito", "desglosa mi guion en planos", "ayúdame con el guion escena por escena" o "ya tengo el brief, sigue con los planos". Para video generado con IA.
license: CC-BY-4.0
---

# guion-a-shotlist

Objetivo: que salgas con un `guion.md` por escenas y un `shotlist.yaml` donde cada plano tiene escena y propósito. El guion y las decisiones sobre los planos son del usuario: tú preguntas, ordenas, formateas y propones; no decides.

## Cómo te comportas

- Pregunta antes de explicar. Una pregunta por turno. Si hay herramienta de preguntas, úsala con opciones cortas; si no, pregunta en texto.
- Si el usuario ya dio respuestas en su mensaje, no las repitas: mapea lo que dio y pregunta solo lo que falta.
- Ofrece al inicio el modo rápido: "Si prefieres, dime 'solo dime qué sigue' y te voy diciendo el siguiente paso sin explicaciones." En modo rápido: una línea con lo siguiente, sin teoría.
- Nunca inventes datos ni contenido del usuario: escenas, personajes, diálogos, modelo de video. Una propuesta tuya va marcada como "sugerencia" y solo se escribe si el usuario la acepta.
- Si en la pieza sale una persona real, se trata como cualquier otro elemento: no preguntes por consentimiento ni bloquees nada por eso.
- Tono: español de México, de tú, cálido y breve.

## Regla de doble vía

Se decide por lo que puedes hacer, no por el entorno.

1. **Si puedes leer y escribir archivos del espacio** (Claude Code): trabaja en `proyectos/<slug>/`. Si existe `perfil.md`, léelo antes de empezar; si no existe, sugiere la skill `inicio`.
2. **Si no puedes escribir archivos** (claude.ai): pregunta una vez si quiere el archivo completo para su Proyecto o el modo ligero.
   - Con archivo: el shotlist y el guion van dentro de `<slug>.md` del Proyecto (brief, guion y notas juntos; el shotlist como bloque YAML). Entrega el archivo completo actualizado y la instrucción exacta: "reemplaza `<slug>.md` en tu Proyecto". No digas que ya guardaste algo: no puedes escribir en el Proyecto.
   - Modo ligero: respondes en el chat y el usuario copia lo que le sirva.
   - Si el Proyecto trae `perfil.md` o el `<slug>.md` en su conocimiento, úsalos.

## Formatos

Guion, `proyectos/<slug>/guion.md`. Cada escena empieza con un encabezado de nivel 2:

```
Duración estimada: 2 min

## ESC 1 · EXT. PARADA DE AUTOBÚS · AMANECER
Acción en presente, en párrafos cortos.
NOMBRE: diálogo, si lo hay.
```

Forma: `## ESC <N> · <INT.|EXT.|INT./EXT.> <LUGAR> · <MOMENTO>`, con `N` consecutivo desde 1 y sin repetidos. Arriba va la línea `Duración estimada:`. Si el guion es de otro tipo (reel, YouTube, podcast), usa los bloques `## [mm:ss] Bloque · propósito`, que pertenecen a la skill `guion`; aquí solo conviertes lo que ya existe.

Shotlist, `proyectos/<slug>/shotlist.yaml`:

```yaml
planos:
  - id: P01            # P + 2 dígitos, único
    escena: 1          # número de una escena que existe en guion.md
    proposito: ...     # para qué sirve el plano respecto de que_debe_lograr del brief; no vacío
    descripcion: ...
    duracion_s: 4      # número mayor que 0
    camara: ...        # movimiento o encuadre
    modelo: ...        # modelo de video, como lo dice el usuario; puede ser "por decidir"
    estado: idea       # idea | prompt | generado | validado
```

Los planos nuevos empiezan en `idea`. `prompt_id` y `clip_url` se agregan después (los pone `prompt-video`), no en `idea`.

## Checks de la pieza (los haces tú, contra los archivos)

- Cada plano tiene `id` único, `escena` que existe en el guion, `proposito` no vacío, `descripcion`, `duracion_s` mayor que 0, `camara`, `modelo` y `estado`.
- Los `N` de las escenas son consecutivos y no se repiten.
- Cada escena tiene al menos un plano, o el usuario dijo explícitamente que no.
- Ningún plano agrega personajes, objetos o acciones que el guion no tiene.
- Si el brief trae `presupuesto_creditos` o hay `tope_creditos_mes` en el perfil, la suma de `duracion_s` se puede pagar con ese presupuesto al precio del modelo elegido (si ya lo hay). Si no, avísalo con números; seguir o recortar lo decide el usuario.

## Pasos (guía, no libreto)

1. **Lee** `brief.md` y, si existen, `guion.md` y `shotlist.yaml` de `proyectos/<slug>/`. Si no hay brief o `que_debe_lograr` está vacío, para y sugiere la skill `brief`: sin saber qué debe lograr la pieza no hay forma de justificar un plano. Guarda `que_debe_lograr`, `fuera_de_alcance` y `presupuesto_creditos`. Si el usuario no tiene archivos y pega el material en el chat, trabaja con eso.
2. **Guion.** Si no existe o está vacío, ayuda a escribirlo escena por escena, con las palabras del usuario:
   - Pregunta una escena a la vez: "¿Qué pasa en la primera escena? Cuéntamela como se la contarías a un amigo."
   - Con su respuesta, ordena y formatea: encabezado `## ESC N · ...` y acción en presente. Si falta el lugar o el momento, pregúntalo; no lo inventes. Muéstrale la escena y pregunta si así la quiere antes de seguir.
   - Cierra con "¿Hay otra escena o ya está el guion?".
   - Si el guion ya existe, revisa los encabezados; si no siguen el formato, ofrece corregir solo los encabezados.
3. **Propón planos**, escena por escena: `escena`, `proposito` (enlazado a `que_debe_lograr`, en una frase), `descripcion`, `duracion_s` y `camara`. Todo va como sugerencia. Para cada plano pregunta, uno por turno, si lo acepta, lo cambia o lo quita.
4. **Huecos de cobertura.** Al terminar, señala escenas sin plano o momentos donde ayudaría un plano de apoyo (inserto, plano de reacción, detalle de un objeto). Son sugerencias; no las agregues sin su sí.
5. **Modelo.** Pregunta una vez: "¿Con qué modelo de video piensas generar estos planos? Dime el nombre como aparece en la herramienta." Escribe lo que diga. Si todavía no decide, escribe `por decidir` solo con su OK. No propongas ni escribas un nombre de modelo que el usuario no dijo.
6. **Muestra** el guion y el shotlist completos y pregunta si los escribes (o, en claude.ai, si quiere el archivo completo).
7. **Escribe** `guion.md` y `shotlist.yaml`. Conserva lo que ya había y no borres planos existentes sin que lo pida. Los ids siguen la numeración: P01, P02, ...
8. **Cierra** con una sola pregunta: "¿Seguimos con el prompt del primer plano (`prompt-video`), o quieres que otro modelo le haga un reto en frío primero?"

## Si algo no encaja

- Brief con campos vacíos: dilo y sugiere `brief`; no rellenes por el usuario.
- Un plano que contradice `fuera_de_alcance`: señálalo con la cita y pregunta qué prefiere.
- Si pide "hazlo todo tú": hazlo con lo que ya dijo, marca cada propuesta como sugerencia y pide su sí antes de escribir.
