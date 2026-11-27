#!/bin/sh
# PreToolUse hook for the Higgsfield MCP tools that spend credits.
# It refuses to spend credits unless, after the last real spend in this session, the transcript
# shows a `balance` call and, for tools that accept a quote, a quote as well.
# POSIX sh + awk only (no python, no jq). Any doubt or internal error exits 2: fail closed.
#
# Rules, in order:
#   1. A quote always passes: tool_input with "get_cost": true (and no "get_cost": false, so one
#      real item inside a batch voids it), or ads_studio_generate without expected_credits (that
#      first call only quotes and asks for approval).
#   2. Any tool outside SPEND passes.
#   3. A real spend passes only if the transcript, after the last real spend, has a `balance` call
#      and, when the tool is in QUOTABLE, a quote (get_cost true, ads_studio_quote, or
#      ads_studio_generate without expected_credits). Non-quotable tools (upscale_video,
#      execute_preset, ...) only need the balance.
#   4. If the transcript cannot be read, block.
#
# Transcript format assumed (Claude Code 2.1.x): JSONL, one compact JSON event per line. Each tool
# call shows up in an assistant message as
#   {"type":"tool_use","id":"toolu_...","name":"mcp__<server>__<tool>","input":{...}}
# The server segment differs per account, so only the tool suffix is compared. Text quoted inside
# messages or tool results arrives with escaped quotes (\"type\":\"tool_use\"), so it never matches
# a real call. If the call being evaluated is already written to the transcript, it is skipped by
# its tool_use_id; without that id it would count as a previous spend and block (the safe side).

trap 'exit 2' EXIT
set -u

SPEND='generate_(video|image|audio|3d)(_batch)?|execute_preset|upscale_(image|video)|outpaint_image|remove_background|reframe|ads_studio_generate|ai_influencer_generate|build_ai_influencer|shorts_studio_create|scene_builder_3d_generate_(video|angles)|motion_control|dubbing|voice_change|create_voice(_from_confirmed_audio)?|apps_invoke'
QUOTABLE='generate_(video|image|audio|3d)(_batch)?|upscale_image|outpaint_image|reframe|shorts_studio_create|ads_studio_generate'
DOC_URL='https://github.com/daniknn/estudio-ia/blob/main/docs/creditos.md'

payload=$(cat | tr '\n\r' '  ')

allow() { trap - EXIT; exit 0; }

deny() { # $1 what happened, $2 how to get unblocked
  {
    printf '✋ Qué pasó: %s\n' "$1"
    printf 'Por qué: los créditos de Higgsfield se gastan al generar y no se reembolsan; generar sin ver tu saldo ni el costo puede dejarte sin créditos o pasarte de tu presupuesto. Más detalle: %s\n' "$DOC_URL"
    printf 'Qué puedes hacer:\n'
    printf '  1. Pide la cotización (get_cost true): no gasta nada y te dice cuánto costaría.\n'
    printf '  2. Consulta tu saldo (balance) y compáralo con lo que quieres gastar.\n'
    printf '  3. Si no te alcanza, baja la duración o la resolución, o sube tu propio presupuesto.\n'
    printf 'Cómo destrabar: %s\n' "$2"
  } >&2
  trap - EXIT
  exit 2
}

json_str() { # $1 key; prints the first string value for that key, unescaped
  printf '%s' "$payload" \
    | sed -n -E 's/.*"'"$1"'"[[:space:]]*:[[:space:]]*"(([^"\\]|\\.)*)".*/\1/p' \
    | head -n 1 \
    | sed -e 's/\\"/"/g' -e 's/\\\\/\\/g'
}

has() { printf '%s' "$payload" | grep -Eq "$1"; }

full_name=$(json_str tool_name)
tool=${full_name##*__}
needs_quote=1

if [ -n "$full_name" ]; then
  case $full_name in mcp__*) ;; *) allow ;; esac
  printf '%s' "$tool" | grep -Eqx "$SPEND" || allow
  printf '%s' "$tool" | grep -Eqx "$QUOTABLE" || needs_quote=0
fi
# No readable tool name: treat it as a quotable spend and require the transcript.

# ads_studio_generate without expected_credits only quotes: it spends nothing.
if [ "$tool" = ads_studio_generate ] && ! has '"expected_credits"'; then
  allow
fi

# A quote: get_cost true and no get_cost false anywhere in the input.
if has '"get_cost"[[:space:]]*:[[:space:]]*true' && ! has '"get_cost"[[:space:]]*:[[:space:]]*false'; then
  allow
fi

transcript=$(json_str transcript_path)
if [ -z "$transcript" ] || [ ! -f "$transcript" ] || [ ! -r "$transcript" ]; then
  deny "no pude comprobar que revisaste tu saldo y el costo antes de generar." \
       "pide la cotización (get_cost true), consulta tu saldo (balance) en esta sesión y vuelve a pedir la generación."
fi

current_id=$(json_str tool_use_id)

if awk -v current_id="$current_id" -v spend_re="^mcp__.*__($SPEND)\$" -v needs_quote="$needs_quote" '
  BEGIN { saw_balance = 0; saw_quote = 0 }
  {
    line = $0
    gsub(/"type":"tool_use"/, "\001&", line)
    count = split(line, blocks, "\001")
    for (i = 2; i <= count; i++) {
      b = blocks[i]
      if (current_id != "") {
        at = index(b, "\"id\":\"" current_id "\"")
        if (at > 0 && at < 40) continue
      }
      if (!match(b, /"name":"mcp__[^"]*"/)) continue
      name = substr(b, RSTART + 8, RLENGTH - 9)
      if (name ~ /__balance$/) {
        saw_balance = 1
      } else if (name ~ /__ads_studio_quote$/) {
        saw_quote = 1
      } else if (name ~ spend_re) {
        if (b ~ /"get_cost"[ ]*:[ ]*true/ && b !~ /"get_cost"[ ]*:[ ]*false/) saw_quote = 1
        else if (name ~ /__ads_studio_generate$/ && b !~ /"expected_credits"/) saw_quote = 1
        else { saw_balance = 0; saw_quote = 0 }
      }
    }
  }
  END { exit (saw_balance && (saw_quote || needs_quote == 0)) ? 0 : 1 }
' "$transcript"; then
  allow
fi

deny "intentaste gastar créditos sin consultar tu saldo (y sin cotizar, si la herramienta lo permite) después de tu último gasto." \
     "consulta tu saldo (balance); si la herramienta acepta get_cost, pide la cotización; revisa que te alcance y vuelve a pedirlo. Se repite antes de cada gasto."
