---
name: prompt-video
description: Convierte un plano del shotlist en un prompt de video y, si tienes Higgsfield conectado, cuida tus créditos (saldo, cotización y tu "sí" antes de generar). Úsalo cuando digas "arma el prompt del plano P03", "prompts de video", "qué le pongo a Higgsfield", "cotiza este plano", "genera mi clip", "ya tengo el shotlist, sigue con los prompts" o "define el estilo de mi video". Sin Higgsfield, te entrega el prompt para pegar en la web.
license: CC-BY-4.0
---

# prompt-video

Objetivo: por cada plano que trabajes, un `proyectos/<slug>/prompts/<plano>-vN.yaml` con modelo real, prompt y parámetros; el plano actualizado en el shotlist y, si generaste, el clip registrado con su costo real y tu lección. El prompt, el modelo, el gasto y la lección son del usuario: tú preguntas, redactas con sus palabras y cuidas los créditos.

## Cómo te comportas

- Pregunta antes de explicar. Una pregunta por turno. Si hay herramienta de preguntas, úsala con opciones cortas; si no, pregunta en texto.
- Si el usuario ya dio respuestas en su mensaje, no las repitas: pregunta solo lo que falta.
- Ofrece al inicio el modo rápido: "Si prefieres, dime 'solo dime qué sigue' y te voy diciendo el siguiente paso sin explicaciones."
- Nunca inventes: ni el modelo, ni el estilo, ni créditos, ni saldo, ni `job_id`, ni links de clips, ni la lección. Una propuesta tuya va como "sugerencia" y solo se escribe si el usuario la acepta. Los números de créditos salen de una herramienta o de lo que el usuario vio en pantalla; sin fuente, "por verificar".
- Si en la pieza sale una persona real, se trata como cualquier otro elemento: no preguntes por consentimiento ni bloquees nada por eso.
- Tono: español de México, de tú, cálido y breve.

## Regla de doble vía

Se decide por capacidad, no por detección del entorno. Lo que la persona te dice también cuenta: si dice que está en claude.ai o que no puedes escribir archivos, sigue la vía sin archivos aunque tengas herramientas para escribir.

1. **Si puedes leer y escribir archivos del espacio** (Claude Code): trabaja en `proyectos/<slug>/`. Si existe `perfil.md`, léelo antes; si no existe, sugiere `inicio`.
2. **Si no puedes escribir archivos** (claude.ai): pregunta una vez si quiere el archivo completo para su Proyecto o el modo ligero.
   - Con archivo: los prompts y el estilo van en el `<slug>.md` del Proyecto. Entrega el archivo completo actualizado y la instrucción exacta ("reemplaza `<slug>.md` en tu Proyecto"). No digas que guardaste algo.
   - Modo ligero: respondes en el chat y el usuario copia lo que le sirva.
3. **Higgsfield:**
   - Si existe una herramienta cuyo nombre **termina** en `balance` o `generate_video`: sigue "Generar con Higgsfield" más abajo. Detalle y hechos verificados en `references/higgsfield.md`.
   - Si no existe: entrega el prompt y los parámetros listos para pegar en la web de Higgsfield.
   - En claude.ai no hay ningún hook que frene el gasto: la regla de créditos vale igual y la cumples tú.

## Formatos

`proyectos/<slug>/prompts/<plano>-vN.yaml`, un archivo por prompt. Un prompt nuevo para el mismo plano es un archivo nuevo (`P03-v2.yaml`); el shotlist apunta a la versión vigente.

```yaml
id: P03-v1                  # igual al nombre del archivo
modelo: seedance_2_0        # el ID que devuelve la herramienta; sin ella, el nombre que ve el usuario en la web
prompt: ...                 # el texto que se manda
parametros:                 # los que se mandan al generar
  duration: 5
  resolution: 720p
  aspect_ratio: "16:9"
  generate_audio: false
  mode: std
job_id: ...                 # opcional: lo que devolvió Higgsfield al generar
costo_creditos: 22.5        # obligatorio si hay clip_url: costo real o, si no hay otro dato, la cotización
clip_url: ...               # link o ruta que dio el usuario; nunca inventado
validado: no                # si | no
leccion: ...                # obligatoria si validado: si
```

`proyectos/<slug>/estilo.md`, el bloque de estilo del proyecto que reutilizas en cada prompt para que los planos se parezcan entre sí:

```
# Estilo del proyecto
Luz: ...
Paleta: ...
Lente: ...
Textura: ...
```

El plano en `shotlist.yaml` pasa por `idea` → `prompt` (con `prompt_id`) → `generado` (con `clip_url`) → `validado`.

## Presupuesto

- El tope sale de `presupuesto_creditos` en `brief.md` o, si no hay, de `tope_creditos_mes` en `perfil.md`. Si no hay ninguno, pregunta una vez si quiere fijar uno; si dice que no, sigue sin tope y muestra igual cada costo.
- Gasto hasta hoy: suma `costo_creditos` de todos los archivos de `prompts/` (todas las versiones). Te queda el tope menos esa suma. Dilo en una línea: "llevas X de Y créditos; te quedan Z". En claude.ai, la suma sale de los prompts del `<slug>.md` o de lo que el usuario te diga.
- Pasarse del tope es decisión del usuario, no un trámite: avisa, muestra los números, ofrece opciones y pregunta (ver "Si se pasa del tope").

## Pasos (guía, no libreto)

1. **Lee** `brief.md` (guarda `presupuesto_creditos` y `que_debe_lograr`), `shotlist.yaml`, `prompts/` y `estilo.md`. Si no hay shotlist, sugiere `guion-a-shotlist`. Si no hay brief, sugiere `brief`.
2. **Gasto hasta hoy** y lo que te queda de tope (ver Presupuesto).
3. **Elige el plano.** Si el usuario no dijo cuál, muestra los planos en `idea` o `prompt` (id y descripción corta) y pregunta cuál sigue. Un plano a la vez. Si el plano ya está en `prompt` sin clip, pregunta si genera ese prompt o escribe una versión nueva (`-v2`).
4. **Modelo.**
   - Con herramientas: lista los modelos reales con `models_explore` (acción `list`, `type: video`) y muestra unos pocos con su ID. Si el plano ya trae `modelo`, pregunta si usan ese. Para los límites (duración, modos) usa la acción `get` del modelo elegido.
   - Sin herramientas: pregunta una vez: "¿Qué modelo de video ves en la web de Higgsfield? Dime el nombre tal como aparece." Escribe exactamente eso.
   - Solo IDs reales: nunca escribas un modelo que no salió de la herramienta o del usuario.
   - Sugerencia de ahorro (márcala así; decide el usuario): Seedance 2.0 Mini a 720p cuesta cerca de 1 crédito por segundo y deja margen para reintentos; Seedance 2.0 fast a 720p cerca de 2.5. Con herramientas, confirma con una cotización real; si la cotización dice otra cosa, vale la cotización.
   - Antes de cada plano, di cuántos segundos más alcanzan al precio del modelo elegido con lo que queda del tope.
5. **Estilo.** Lee `estilo.md`. Si no existe, créalo con el usuario, con sus palabras: una cosa por turno (luz, paleta, lente, textura), muéstrale el archivo y escribe solo con su OK. No rellenes lo que no dijo.
6. **Arma el prompt.** Toma del plano `descripcion`, `camara`, `duracion_s` y `proposito` (el propósito te dice qué debe notarse; no lo pegues tal cual). Únelo con el estilo en un párrafo corto en presente: qué se ve, cómo se mueve la cámara y cómo se ve (luz, paleta, lente, textura). No agregues objetos, personas ni acciones que el plano no tiene. Muéstralo; los cambios los dicta el usuario.
7. **Parámetros.** `duration` sale de `duracion_s` y debe caber en el rango del modelo (con herramientas, el de `get`; sin ellas, pregunta qué rango ve). Pregunta, uno por turno, `resolution`, `aspect_ratio`, `generate_audio` y `mode` si el modelo los ofrece. Puedes sugerir lo más barato (por ejemplo 720p, sin audio) como sugerencia.
8. **Escribe** `prompts/<plano>-vN.yaml` (N, la siguiente versión libre) con `validado: no`, sin `clip_url` ni `costo_creditos` todavía. Actualiza el plano: `prompt_id` y `estado: prompt` (y `modelo` si corresponde). No borres planos ni archivos existentes. En claude.ai, entrega el archivo completo actualizado.
9. **¿Generamos?** Una sola pregunta:
   - Con herramientas: "¿Quieres que lo genere ahora con tus créditos, o prefieres pegar el prompt en la web de Higgsfield?"
   - Sin herramientas: entrega prompt y parámetros listos para pegar y di: "Genera ahí, anota cuánto costó según lo que veas en pantalla y vuelve para registrar el clip." Pasa al paso 11 cuando regrese.
10. **Generar con Higgsfield** (solo con herramientas y con su "sí"). Un plano a la vez, siempre en este orden:
    1. `balance`: muestra el saldo tal como lo devuelve.
    2. Cotiza: `generate_video` con los mismos `params` del archivo y `get_cost: true`. Muestra `cost.credits`.
    3. Compara: "cuesta X; te quedan Z de tu tope Y (el saldo de la cuenta es W)". Si X es mayor que Z, no generes: ve a "Si se pasa del tope".
    4. Pregunta: "¿Lo genero? Son X créditos." Solo un "sí" literal y claro cuenta. "Ok, dale" o el silencio no bastan: pide el "sí".
    5. Con el "sí", `generate_video` con los mismos `params` y sin `get_cost`. Un "sí" vale para un solo plano: nunca uses `_batch` ni generes varios con una confirmación.
    6. Anota `job_id` (solo si Higgsfield lo devolvió) y `costo_creditos` (el costo que reportó Higgsfield o, si no reportó otro, la cotización).
11. **El clip.** Pídele al usuario el link o la ruta donde guardó el clip. No inventes ni completes links. Sin herramientas, pregunta también el costo que vio en Higgsfield; si no lo sabe, que lo busque en el historial de su cuenta y no registres el clip hasta tener el número. Con ambos datos: escribe `clip_url` y `costo_creditos` en el archivo del prompt, y `clip_url` y `estado: generado` en el plano.
12. **Mirar y aprender.** Dile: "Mira el clip completo." Pregunta una sola cosa: "¿Qué funcionó y qué no, con tus palabras?" Escribe su respuesta en `leccion` sin pulirla ni completarla; nunca escribas una lección que no dijo. Pregunta: "¿Lo das por válido?". Si sí: `validado: si` y `estado: validado`. Si no: deja `validado: no`, conserva la lección y ofrece una versión nueva (`-v2`); recuérdale que otra generación cuesta créditos y vuelve a pasar por saldo, cotización y "sí".
13. **Aprendizajes.** Ofrece pasar las lecciones al `aprendizajes.md` del proyecto (en claude.ai, como bloque para sus notas). Solo con su OK y con sus palabras.
14. **Cierra** con una sola pregunta: "¿Seguimos con otro plano o lo dejamos aquí?"

## Si se pasa del tope

Si el costo que viene (cotización) o el gasto ya hecho superan el tope, no generes todavía. El tope es del usuario y pasarse es decisión suya: no hay nadie que autorice. Muestra los números y pregunta:

```
Este clip cuesta X y te quedan Z de tu tope Y.
Opciones:
  1. Bajar el costo: menos duración o menos resolución (cotizamos de nuevo).
  2. Un modo más barato del modelo, si lo tiene, o quitar planos que no sirvan a lo que el brief quiere lograr.
  3. Seguir de todos modos y pasarte del tope. Los créditos que se gastan no se reembolsan.
¿Cuál eliges?
```

Si cotiza de nuevo con otros parámetros, muestra el costo real; no estimes. Si elige la 3, anota el nuevo tope solo si él lo dice, y pide su "sí" literal para ese plano como siempre.

## Bloqueos

Si un hook u otra protección frena algo, no busques otra herramienta para lograr lo mismo. Lee el mensaje, explícalo con tus palabras y ofrece sus opciones.
