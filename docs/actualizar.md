# Actualizar

Cada vía se actualiza de forma distinta.

## Claude Code

1. Actualiza el marketplace y el plugin desde `/plugin` (opción de actualizar), o vuelve a correr `/plugin marketplace add daniknn/estudio-ia`.
2. Si algo no aparece, corre `claude update` para tener la última versión de Claude Code y reinicia.
3. Tus archivos (`perfil.md`, `wiki/`, `proyectos/`) no se tocan: las actualizaciones solo cambian las skills.

**Versión visible:** la versión del plugin está en `plugins/estudio-ia/.claude-plugin/plugin.json` y en el listado de `/plugin`. La versión actual de esta guía es 0.1.0.

## claude.ai

1. Entra a la última Release del repositorio y descarga los zips nuevos.
2. En Customize, Skills, sube de nuevo cada zip para reemplazar la versión anterior.
3. Si cambió `claude-ai/instrucciones-proyecto.md`, pega el texto nuevo en las instrucciones de tu Proyecto.
4. Tus archivos del Proyecto (`perfil.md`, `wiki.md`, proyectos) no cambian solos: se actualizan cuando reemplazas el archivo que Claude te entrega.

## Antes de actualizar

Lee las notas de la Release para saber qué cambió. Si algo cambia en el formato de tus archivos, ahí se explica cómo adaptarlos.

Recuerda no instalar la misma skill por las dos vías en la misma cuenta. Mira [instalar.md](instalar.md).
