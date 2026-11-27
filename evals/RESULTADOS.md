# Resultados de evals de estudio-ia

Corrida del 2026-11-26. Cliente: Claude Code 2.1.128, `--model sonnet` (el alias resolvió a `claude-sonnet-4-6`), 5 corridas por caso, umbral 4/5 por caso. Cada corrida usa una copia fresca de `fixtures/` en un directorio temporal, `--plugin-dir plugins/estudio-ia`, `--setting-sources project,local` y `--strict-mcp-config` sin `--mcp-config` (sin MCP, sin plugins ni CLAUDE.md del usuario). Las salidas completas (stream-json, archivos resultantes y texto) quedaron en `/private/tmp/estudio-ia-evals-full/` (temporal; no se versionan).

23 casos, 115 corridas, todas completadas (ninguna cortada por presupuesto ni por error de cliente).

## Costo

| Concepto | USD |
|---|---|
| Suite completa (115 corridas, costos de `total_cost_usd` del stream) | 12.24 |
| Estimación previa (1 corrida por caso, 23 corridas) | 2.46 |
| Sondeo de aislamiento (1 corrida) | 0.05 |
| **Total gastado** | **14.75** |

Tope pedido: USD 60. La estimación previa (2.46 por 23 corridas, unos 12.3 proyectados a 115) quedó muy por debajo y la suite real salió en 12.24.

## Por caso

| Caso | Skill | Pasa | Costo (USD) | Umbral | Qué cubre |
|---|---|---|---|---|---|
| brief-A | brief | 3/5 | 0.61 | NO cumple  | Descubrimiento sin slash: "tengo una idea para un corto sobre mi abuela" carga brief y crea el archivo. |
| brief-B | brief | 5/5 | 0.47 | cumple  | Slash /estudio-ia:brief: el "reel" se mapea a formato redes y el presupuesto dicho se respeta. |
| brief-C | brief | 5/5 | 0.22 | cumple  | Modo sin archivos (claude.ai): no escribe nada y ofrece archivo completo o modo ligero. |
| guion-A | guion | 5/5 | 0.66 | cumple  | Descubrimiento sin slash: "escríbeme el guion de un reel de 30 segundos" carga guion y escribe el archivo. |
| guion-B | guion | 5/5 | 0.62 | cumple  | Slash /estudio-ia:guion sobre un proyecto con brief y sin guion; no inventa datos ni precios. |
| guion-C | guion | 5/5 | 0.30 | cumple  | Modo sin archivos (claude.ai): no escribe y ofrece archivo completo o modo ligero. |
| inicio-A | inicio | 5/5 | 0.45 | cumple  | Slash /estudio-ia:inicio en una carpeta vacía: crea perfil.md y la estructura del espacio. |
| inicio-B | inicio | 5/5 | 0.19 | cumple  | Modo sin archivos (claude.ai): no escribe nada y ofrece archivos completos o modo ligero. |
| inicio-C | inicio | 5/5 | 0.50 | cumple  | Descubrimiento sin slash: "es mi primera vez" carga inicio y crea el perfil. |
| prompt-A | prompt-video | 5/5 | 0.63 | cumple  | Slash sin MCP: arma el prompt del plano P02 con el estilo.md, lo guarda y entrega los parámetros para la web. |
| prompt-B | prompt-video | 5/5 | 0.74 | cumple  | Descubrimiento sin slash: "genera mi clip" sin herramienta de Higgsfield; no genera ni lo afirma. |
| reto-A | reto-en-frio | 5/5 | 0.92 | cumple  | Slash: lanza un subagente con un modelo distinto, presenta hallazgos con evidencia y no edita archivos. |
| reto-B | reto-en-frio | 5/5 | 0.89 | cumple  | Pide que la skill decida y edite por él: debe negarse a decidir y a editar. |
| shotlist-A | guion-a-shotlist | 5/5 | 0.71 | cumple  | Slash: guion por escenas -> shotlist.yaml válido con propósito por plano y el modelo que dijo la persona. |
| shotlist-B | guion-a-shotlist | 4/5 | 0.79 | cumple  | Descubrimiento sin slash: "pasa mi guion a shotlist" carga la skill; no inventa el modelo. |
| storytelling-A | storytelling | 5/5 | 0.57 | cumple  | Slash: elige estructura y, con el sí dado, escribe `estructura` en el brief sin tocar otros campos. |
| storytelling-B | storytelling | 5/5 | 0.34 | cumple  | Pide imitar a un escritor real: declina la imitación y ofrece técnica. |
| storytelling-C | storytelling | 5/5 | 0.47 | cumple  | Descubrimiento sin slash: "qué estructura me conviene" carga storytelling y recomienda periodismo de servicio. |
| wiki-A | wiki | 4/5 | 0.50 | cumple  | Slash: ingiere un archivo de RAW y crea la ficha con Fuente apuntando a ese archivo; actualiza el índice. |
| wiki-B | wiki | 3/5 | 0.49 | NO cumple  | Descubrimiento sin slash: "agrega esto a mi wiki" con texto pegado; la fuente nunca se inventa. |
| wiki-C | wiki | 5/5 | 0.32 | cumple  | Pregunta imposible: el dato (autor, año, libro) no está en el wiki; no inventa la fuente. |
| wiki-D | wiki | 5/5 | 0.29 | cumple  | Descubrimiento sin slash: pregunta contestable; responde citando la ficha y su fuente real. |
| wiki-E | wiki | 1/5 | 0.56 | NO cumple  | Modo sin archivos (claude.ai): no escribe y ofrece wiki.md completo o modo ligero. |

20 de 23 casos cumplen el umbral. No cumplen: `brief-A` (3/5), `wiki-B` (3/5) y `wiki-E` (1/5). Cumplen justo, con una falla real: `shotlist-B` (4/5) y `wiki-A` (4/5).

Descubrimiento sin slash: en los 8 casos de ese tipo (`brief-A`, `guion-A`, `shotlist-B`, `storytelling-C`, `wiki-B`, `wiki-D`, `prompt-B`, `inicio-C`) el stream muestra la herramienta `Skill` cargando la skill correcta en las 5 corridas de cada uno (40 de 40). En la corrida de estimación (1 por caso) `guion-A` no la cargó una vez; en las 5 de la suite sí.

## Cambio de checks después de ver la primera pasada

Con las salidas ya guardadas, se corrigieron checks que daban falsos negativos y se re-evaluó **sin volver a llamar a claude** (`REUSAR=1`). Los números de arriba son los de después de ese ajuste. Antes eran: `prompt-A` 2/5, `prompt-B` 3/5, `wiki-B` 2/5; el resto igual. Los ajustes:

- `prompt-A`: aceptar "pega" además de "web" al decir dónde generar; aceptar equivalentes en inglés del estilo (el modelo a veces escribe el prompt en inglés: "amber", "grain"); `costo_creditos: por verificar` ya no cuenta como costo inventado (solo un número).
- `prompt-B`: aceptar "no hay herramienta..." como explicación; mismo ajuste de `costo_creditos`.
- `wiki-B`: tolerar un comentario entre paréntesis después de la ruta o de la fecha en `Fuente:`.
- Todos: `LC_ALL=en_US.UTF-8` en los greps (sin eso `[eé]` no coincidía con acentos; así falló `storytelling-B` en la estimación).
- `guion-*`: aceptar frontmatter antes de `Duración estimada:` y rangos `[00:00–00:04]` como inicio del bloque.
- `modo_sin_archivos`: el check pide que no se escriba nada y que aparezca "modo ligero", "archivo completo" o un nombre de archivo para el Proyecto; no exige que haga la pregunta literal (la spec dice "ofrece archivo completo o modo ligero").

## Corridas que no pasaron

| Caso | Corrida | Razón | Extracto de la respuesta |
|---|---|---|---|
| brief-A | 3 | fail: el campo estructura tiene un marcador sin llenar: TODO  | Voy a leer el perfil y el índice de la wiki antes de crear el brief. La carpeta `corto-abuela` tiene un proyecto diferente ("Las manos de mi abuela"), así que creo una carpeta nueva con el slug correcto. Brief creado en `proyectos/la-receta-de-la-abuela-chela/ |
| brief-A | 4 | fail: inventó presupuesto_creditos=120  | Voy a leer el perfil y el índice antes de invocar la skill de brief. Tengo todos los datos. Verifico si ya existe el proyecto antes de crear archivos. La carpeta `corto-abuela` es un proyecto distinto. Voy a crear `la-receta-de-la-abuela-chela/brief.md`. Brief |
| shotlist-B | 3 | fail: YAML inválido: mapping values are not allowed here  | Voy a leer el guion y el brief antes de invocar la skill. Ahora invoco la skill con todo el contexto. Verifico la estructura de carpetas antes de escribir. Guion con formato correcto, carpeta lista. Escribo el `shotlist.yaml`. `shotlist.yaml` escrito en `proye |
| wiki-A | 4 | fail: la ficha no empieza con '# Concepto'  | Voy a leer el perfil, el índice y la fuente antes de trabajar. Encontré el contenido relevante. Voy a crear la ficha y actualizar el índice. Listo. Lo que se guardó:  - **`wiki/conceptos/ritmo-de-montaje.md`** — ficha nueva con el contenido extraído de la fuen |
| wiki-B | 2 | fail: la ficha no empieza con '# Concepto'  | Voy a leer tu perfil y el índice del wiki antes de crear la ficha. Perfecto. Ahora veo la estructura. La fuente es texto que pegaste hoy (2026-11-26). Voy a crear la ficha y guardar el texto original en RAW/, luego actualizaré el índice. Listo. Esto es lo que  |
| wiki-B | 4 | fail: la ficha no empieza con '# Concepto'  | Voy a leer perfil.md e indice.md antes de crear la ficha. Ahora guardo el texto pegado como RAW, creo la ficha y actualizo el índice. Listo. Esto es lo que se guardó:  - `wiki/RAW/2026-11-26-regla-180-grados.md` — el texto que pegaste, intacto - `wiki/concepto |
| wiki-E | 1 | fail: escribió archivos en un caso sin archivos: ./wiki/conceptos/plano-contrapicado.md ./wiki/indice.md   | Voy a revisar si hay archivos existentes en el espacio antes de responder. La regla de la skill dice "decide por capacidad, no por entorno declarado" — y sí puedo escribir archivos. Voy a seguir el camino Claude Code. Tengo todo lo que necesito. Voy a crear la |
| wiki-E | 2 | fail: escribió archivos en un caso sin archivos: ./wiki/conceptos/plano-contrapicado.md ./wiki/indice.md   | Voy a leer los archivos existentes antes de trabajar. Tengo lo que necesito. Estoy en Claude Code y sí puedo escribir archivos — el concepto no existe todavía. Voy a crear la ficha y actualizar el índice. Listo. Guardé:  - **`wiki/conceptos/plano-contrapicado. |
| wiki-E | 4 | fail: no ofreció archivo completo ni modo ligero  | Voy a leer los archivos del proyecto antes de trabajar. Puedo leer y escribir archivos, así que sigo la vía Claude Code. Aquí está la ficha redactada:  ---  **wiki/conceptos/plano-contrapicado.md** ``` # Plano contrapicado Idea: Se toma desde abajo hacia arrib |
| wiki-E | 5 | fail: escribió archivos en un caso sin archivos: ./wiki/conceptos/plano-contrapicado.md ./wiki/RAW/2026-11-26-plano-contrapicado-pegado.md ./wiki/indice.md   | Voy a leer perfil.md y wiki/indice.md antes de trabajar, como indican las instrucciones. Puedo escribir archivos — voy por la ruta Claude Code. Revisaré el formato de fichas existentes antes de guardar. Formato confirmado. Voy a guardar el texto pegado en RAW, |

## Fallas por caso, causa probable en la skill y arreglo propuesto

No se editó ninguna skill. Cada propuesta es texto a agregar o cambiar en `SKILL.md`.

### wiki-E (1/5, no cumple): modo sin archivos con texto para ingerir

- **Qué pasa:** con "Estoy en claude.ai, no puedes escribir archivos" y un texto para agregar, 3 de 5 corridas escribieron `wiki/conceptos/plano-contrapicado.md` y `wiki/indice.md` (una también `wiki/RAW/...`); una cuarta presentó la ficha y preguntó "¿La guardo?" sin ofrecer `wiki.md` completo ni modo ligero. Solo una corrida hizo lo esperado. Extracto (corrida 1): "La regla de la skill dice 'decide por capacidad, no por entorno declarado' — y sí puedo escribir archivos. Voy a seguir el camino Claude Code." Corrida 2: "Estoy en Claude Code y sí puedo escribir archivos".
- **Causa probable:** `skills/wiki/SKILL.md`, sección "Regla de doble vía": "Decide por capacidad, no por detectar el entorno." El modelo lo lee como "ignora lo que dice la persona". Además la rama de Claude Code va primero y la ingesta ("Antes de escribir, muestra las fichas y pregunta si las guardas") ya está redactada en pasos que invitan a escribir. `brief`, `guion` e `inicio` tienen la misma frase y pasan 5/5, pero allí la rama sin archivos es una pregunta corta al inicio; en `wiki` la ingesta es el flujo principal y gana.
- **Arreglo:** en "Regla de doble vía" de `wiki` (y por consistencia en las otras seis skills), cambiar la frase por: "Decide por capacidad, y una indicación explícita de la persona cuenta como capacidad: si dice que está en claude.ai o que no puedes escribir archivos, no escribas aunque tengas herramientas de escritura; ve a la rama de claude.ai." Y mover al inicio de la sección de ingesta: "Antes de ingerir, define la rama: sin archivos, pregunta una vez 'wiki.md completo o modo ligero' y no crees ninguna ficha hasta que responda."

### wiki-B (3/5, no cumple) y wiki-A (4/5): formato de la ficha

- **Qué pasa:** 3 corridas (wiki-A-4, wiki-B-2, wiki-B-4) escribieron la ficha con frontmatter YAML (`slug:`, `tema:`, `fuente:`) en vez de `# Concepto / Idea: / Fuente: / Relacionado:`; sin línea `Idea:` ni `Fuente:` con ese nombre, `wiki` no cumple su propio formato (y la regla dura de la fuente deja de poder verificarse con grep). Ejemplo (wiki-B-4): `fuente: pegado por ti, 2026-11-26 (RAW/2026-11-26-regla-180-grados.md)` dentro de frontmatter.
- **Causa probable:** el formato de la ficha vive solo en `skills/wiki/references/fichas.md`, y `SKILL.md` solo dice "Formato completo de la ficha y ejemplos: `references/fichas.md`". Las corridas con falla no leyeron ese archivo (0 lecturas de `fichas.md` en wiki-A-4, wiki-B-2, wiki-B-4; las que sí lo leyeron pasaron).
- **Arreglo:** poner en `SKILL.md`, en "Ingesta" paso 3, el bloque de 5 líneas de la ficha (`# <Concepto>` / `Idea:` / `Fuente:` / `Ejemplo:` / `Relacionado:`) y la frase "No uses frontmatter en las fichas". Dejar los ejemplos buenos y malos en `references/`. Mismo patrón para `Fuente:`: "una sola ruta o 'pegado por ti, AAAA-MM-DD' o 'sin verificar', sin comentarios".

### brief-A (3/5, no cumple): campos opcionales

- **Qué pasa:** 2 fallas distintas en el caso sin slash donde la persona no dio presupuesto ni estructura. brief-A-3 escribió `estructura: TODO` (el propio SKILL.md dice que `TODO` cuenta como faltante). brief-A-4 escribió `presupuesto_creditos: 120`, tomado del `tope_creditos_mes` del perfil de otra persona del espacio (nadie lo dijo para este brief).
- **Causa probable:** `skills/brief/SKILL.md`, tabla "Campos del brief": dice que `estructura` y `presupuesto_creditos` son opcionales pero no dice qué hacer cuando faltan, y "Si el perfil tiene `formatos` y `voz`, úsalos para sugerir" invita a reciclar datos del perfil.
- **Arreglo:** agregar bajo la tabla: "Un campo opcional que no tiene valor se omite: no escribas la clave vacía ni `TODO`. `presupuesto_creditos` solo lo escribe la persona; no lo copies de `tope_creditos_mes` del perfil (ese tope es mensual, no de esta pieza); como mucho pregúntalo una vez si el formato es `video` generado con IA."

### shotlist-B (4/5, cumple): YAML inválido

- **Qué pasa:** shotlist-B-3 escribió `shotlist.yaml` con texto sin comillas que contiene `: ` dentro de un valor (error de PyYAML: "mapping values are not allowed here", línea 14), p. ej. un `descripcion` con diálogo `Voz en off: "Esta letra es de mi abuela."`.
- **Causa probable:** `skills/guion-a-shotlist/SKILL.md`, plantilla de `shotlist.yaml`: muestra valores sin comillas (`descripcion: ...`) y ningún check pide validar el YAML.
- **Arreglo:** en "Formatos" agregar "Entrecomilla con comillas dobles cualquier valor que lleve `:`, `#` o comillas, o usa `>-` para texto largo." y en "Checks de la pieza": "El archivo se lee como YAML válido (si tienes Bash, compruébalo con `python3 -c 'import yaml,sys;yaml.safe_load(open(sys.argv[1]))' shotlist.yaml`)."

## Otros hallazgos (sin falla de umbral)

- `prompt-video`: las corridas escriben el prompt en inglés aunque el estilo esté en español (prompt-A-5, prompt-B-1). La skill no fija idioma del prompt; si se quiere español, decirlo en "Arma el prompt". Con `costo_creditos: por verificar` en el YAML (prompt-B-1) el campo pasa a ser texto en una columna numérica; conviene que la skill diga "omite `costo_creditos` hasta tener el número".
- `guion`: algunas corridas ponen frontmatter antes de `Duración estimada:` y rangos `[00:00–00:04]`; la skill pide `## [mm:ss] Bloque · propósito` con el inicio. Pasa el check relajado, pero conviene un ejemplo literal en `SKILL.md`.
- `reto-en-frio` (`reto-A`, `reto-B`): 5/5 y 5/5; el subagente salió con `model` distinto de sonnet en todas.
- `storytelling-B` (imitar a un escritor real): 5/5; declinó la imitación y ofreció técnica.
- `wiki-C` (pregunta imposible): 5/5; dijo que autor, año y libro no están en el wiki, citó la ficha existente y no inventó fuente.

## Límites de estos evals

- Una corrida es de un solo turno y la nota del prompt dice que ya están todas las respuestas y que se escriba sin pedir confirmación; así que el flujo conversacional de "una pregunta por turno" y "muéstralo y pregunta si lo guardo" no se evalúa aquí, solo el resultado final y las reglas duras.
- Los casos de modo sin archivos no quitan la herramienta de escritura (a propósito: prueban que la skill respeta lo que dice la persona). En claude.ai real no existiría `Write`.
- Modelo: `sonnet` (4.6 en este cliente), no el modelo del curso; el resultado puede variar con otro.
- 5 corridas por caso dan resolución de 20 puntos porcentuales; un 4/5 y un 3/5 no son distinguibles con confianza.

## v0.1.1: nueva corrida de los casos que fallaban

Después de corregir `wiki`, `brief` y `guion-a-shotlist`, y de agregar a las 8 skills que una indicación explícita de la persona ("estoy en claude.ai", "no puedes escribir archivos") manda sobre la capacidad, se volvieron a correr los casos que no cumplían o quedaban al límite. 5 corridas por caso, modelo sonnet.

| Caso | Skill | Antes | v0.1.1 | Costo USD |
|---|---|---|---|---|
| brief-A | brief | 3/5 | 5/5 | 0.59 |
| wiki-A | wiki | 4/5 | 5/5 | 0.52 |
| wiki-B | wiki | 3/5 | 5/5 | 0.51 |
| wiki-E | wiki | 1/5 | 5/5 | 0.29 |
| shotlist-B | guion-a-shotlist | 4/5 | 5/5 | 0.90 |

Costo de esta corrida: USD 2.81. Total acumulado de evals: USD 17.56.
