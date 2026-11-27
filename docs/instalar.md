# Instalar estudio-ia

Hay dos vías. Elige una; puedes usar la otra después.

- **Claude Code** (la vía completa): trabajas en una carpeta tuya, con wiki, proyectos y archivos reales.
- **claude.ai** (la vía ligera): trabajas en un Proyecto, sin instalar nada en tu computadora.

> **Advertencia:** no instales la misma skill por las dos vías en la misma cuenta. Si instalas el plugin en Claude Code y además subes los zips en claude.ai con la sincronización de skills activa, la skill queda duplicada y puede comportarse de forma impredecible. Usa una sola vía por cuenta, o desactiva la sincronización.

## Vía Claude Code

1. Asegúrate de tener Claude Code actualizado. La primera vez, corre `claude update`.
2. Agrega el marketplace:
   ```
   /plugin marketplace add daniknn/estudio-ia
   ```
3. Instala el plugin:
   ```
   /plugin install estudio-ia@estudio-ia-daniknn
   ```
4. Crea una carpeta vacía para tu estudio, por ejemplo `mi-estudio`. No tienes que descargar nada: `inicio` crea dentro tu perfil, tu wiki y la carpeta de proyectos.
5. Abre Claude Code en esa carpeta y escribe `/estudio-ia:inicio`. Se recomienda usar git en esa carpeta; `inicio` te pregunta si quieres que te explique cómo.

## Vía claude.ai

1. Abre la [última Release](https://github.com/daniknn/estudio-ia/releases/latest. Hasta abajo, en **Assets**, descarga los archivos `.zip` que tienen nombre de skill: `inicio.zip`, `wiki.zip`, `brief.zip`, `guion.zip` y los demás (son 13). No descargues los de **Source code**: son el código del repositorio y no sirven para subir. Para probar rápido bastan `inicio.zip`, `brief.zip` y `guion.zip`.
2. No descomprimas los zips. Si tu navegador los abrió solo y ves carpetas en lugar de archivos `.zip` (pasa con Safari en Mac), descárgalos de nuevo con Chrome o desactiva en Safari la opción de abrir archivos seguros después de descargarlos.
3. En claude.ai abre Customize, luego Skills, y elige Upload. Sube un zip a la vez.
4. Activa la ejecución de código en tus ajustes. Sin ella, las skills no funcionan completas.
5. Crea un Proyecto llamado "Mi estudio".
6. Abre un chat dentro del Proyecto y escribe "quiero empezar". `inicio` te hace unas preguntas y te entrega tu `perfil.md`, tu `wiki.md` y el texto de instrucciones del Proyecto, y te dice dónde va cada uno. No tienes que descargar nada más del repositorio.

Las plantillas de `claude-ai/` en el repositorio son de referencia; no hace falta descargarlas.

## Actualizar

Cada vía se actualiza distinto. Mira [actualizar.md](actualizar.md).

## Desinstalar

- **Claude Code:** `/plugin uninstall estudio-ia@estudio-ia-daniknn`. Para quitar también el marketplace: `/plugin marketplace remove estudio-ia-daniknn`. Tu carpeta de espacio no se borra: es tuya.
- **claude.ai:** en Customize, Skills, quita cada skill de estudio-ia. Borra el Proyecto "Mi estudio" solo si ya no quieres sus archivos.

## Si algo falla

- El comando `/estudio-ia:inicio` no aparece: revisa que el plugin esté instalado con `/plugin` y reinicia Claude Code.
- En claude.ai la skill no se activa: confirma que subiste el zip de esa skill y que la ejecución de código está activa.
