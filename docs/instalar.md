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
4. Crea una carpeta para tu espacio y copia dentro el contenido de `espacio/` de este repositorio. Se recomienda usar git en esa carpeta.
5. Abre Claude Code en esa carpeta y escribe `/estudio-ia:inicio`.

## Vía claude.ai

1. Descarga los zips de la última Release del repositorio. Hay uno por skill.
2. En claude.ai abre Customize, luego Skills, y elige Upload. Sube un zip por skill (son 13).
3. Activa la ejecución de código en tus ajustes. Sin ella, las skills no funcionan completas.
4. Crea un Proyecto llamado "Mi estudio".
5. En las instrucciones del Proyecto, pega el contenido de `claude-ai/instrucciones-proyecto.md`.
6. Sube al Proyecto los archivos `claude-ai/perfil.md` y `claude-ai/wiki.md`, llenando primero tu perfil. Por cada proyecto, sube una copia de `claude-ai/proyecto-plantilla.md` con su nombre.
7. Abre un chat dentro del Proyecto y escribe "quiero empezar".

## Actualizar

Cada vía se actualiza distinto. Mira [actualizar.md](actualizar.md).

## Desinstalar

- **Claude Code:** `/plugin uninstall estudio-ia@estudio-ia-daniknn`. Para quitar también el marketplace: `/plugin marketplace remove estudio-ia-daniknn`. Tu carpeta de espacio no se borra: es tuya.
- **claude.ai:** en Customize, Skills, quita cada skill de estudio-ia. Borra el Proyecto "Mi estudio" solo si ya no quieres sus archivos.

## Si algo falla

- El comando `/estudio-ia:inicio` no aparece: revisa que el plugin esté instalado con `/plugin` y reinicia Claude Code.
- En claude.ai la skill no se activa: confirma que subiste el zip de esa skill y que la ejecución de código está activa.
