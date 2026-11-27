#!/bin/sh
# Tests for the Higgsfield credit-balance hook: feed JSON to the script and compare exit codes.
# Usage: sh plugins/estudio-ia/hooks/tests/run.sh
HERE=$(cd "$(dirname "$0")" && pwd)
HOOKS=$(dirname "$HERE")
HOOK="$HOOKS/saldo-higgsfield.sh"
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

pass=0; fail=0
ok()  { pass=$((pass + 1)); printf 'ok   %s\n' "$1"; }
bad() { fail=$((fail + 1)); printf 'FAIL %s\n' "$1"; }

expect() { # $1 name, $2 expected exit code, $3 hook input
  out=$(printf '%s' "$3" | sh "$HOOK" 2>&1 >/dev/null); code=$?
  if [ "$code" = "$2" ]; then ok "$1 (exit $code)"
  else bad "$1 (expected $2, got $code)"; printf '%s\n' "$out"; fi
  LAST=$out
}

SRV=mcp__aaaa-bbbb
add() { printf '%s\n' "$1" >> "$2"; }
call() { # $1 id, $2 tool, $3 input JSON: one transcript line with an MCP call
  printf '{"type":"assistant","message":{"role":"assistant","content":[{"type":"tool_use","id":"toolu_%s","name":"%s__%s","input":%s}]}}\n' "$1" "$SRV" "$2" "$3"
}
new_tr() { : > "$TMP/$1.jsonl"; printf '%s' "$TMP/$1.jsonl"; }

BAL='{}'
QUOTE='{"params":{"model":"seedance_2_0","prompt":"x","duration":5,"get_cost":true}}'
REAL='{"params":{"model":"seedance_2_0","prompt":"x","duration":5,"get_cost":false}}'
REAL_NO_FLAG='{"params":{"model":"seedance_2_0","prompt":"x","duration":5}}'

gen() { # $1 tool, $2 transcript_path, $3 get_cost (true|false|none)
  case $3 in
    none) ti='{"params":{"model":"seedance_2_0","prompt":"x"}}' ;;
    *) ti='{"params":{"model":"seedance_2_0","prompt":"x","get_cost":'$3'}}' ;;
  esac
  printf '{"session_id":"s","transcript_path":"%s","cwd":"/","hook_event_name":"PreToolUse","tool_name":"%s__%s","tool_input":%s,"tool_use_id":"toolu_current"}' "$2" "$SRV" "$1" "$ti"
}
other() { # $1 tool, $2 transcript_path, $3 tool_input JSON
  printf '{"session_id":"s","transcript_path":"%s","tool_name":"%s__%s","tool_input":%s,"tool_use_id":"toolu_current"}' "$2" "$SRV" "$1" "$3"
}

# ---------------------------------------------------------------- transcripts
EMPTY=$(new_tr empty); add '{"type":"user","message":{"role":"user","content":"hola"}}' "$EMPTY"
ONLY_BAL=$(new_tr onlyBalance); add "$(call 1 balance "$BAL")" "$ONLY_BAL"
ONLY_QUOTE=$(new_tr onlyQuote); add "$(call 1 generate_video "$QUOTE")" "$ONLY_QUOTE"
BOTH=$(new_tr both); add "$(call 1 balance "$BAL")" "$BOTH"; add "$(call 2 generate_video "$QUOTE")" "$BOTH"
BOTH_REV=$(new_tr bothReversed); add "$(call 1 generate_video "$QUOTE")" "$BOTH_REV"; add "$(call 2 balance "$BAL")" "$BOTH_REV"
SPENT=$(new_tr spentOnce); cp "$BOTH" "$SPENT"; add "$(call 3 generate_video "$REAL")" "$SPENT"
SPENT_AGAIN=$(new_tr spentThenRechecked); cp "$SPENT" "$SPENT_AGAIN"
add "$(call 4 balance "$BAL")" "$SPENT_AGAIN"; add "$(call 5 generate_video "$QUOTE")" "$SPENT_AGAIN"
CUR_WRITTEN=$(new_tr currentWritten); cp "$BOTH" "$CUR_WRITTEN"; add "$(call current generate_video "$REAL")" "$CUR_WRITTEN"
QUOTED=$(new_tr quotedText)
add '{"type":"user","message":{"role":"user","content":"{\"type\":\"tool_use\",\"id\":\"toolu_9\",\"name\":\"mcp__aaaa-bbbb__balance\",\"input\":{}} {\"type\":\"tool_use\",\"id\":\"toolu_8\",\"name\":\"mcp__aaaa-bbbb__generate_video\",\"input\":{\"get_cost\":true}}"}}' "$QUOTED"
NO_FLAG=$(new_tr spentNoFlag); cp "$BOTH" "$NO_FLAG"; add "$(call 3 generate_video "$REAL_NO_FLAG")" "$NO_FLAG"
BATCH=$(new_tr batchSpent); cp "$BOTH" "$BATCH"; add "$(call 3 generate_video_batch "$REAL")" "$BATCH"
SAME_LINE=$(new_tr sameLine)
add "{\"type\":\"assistant\",\"message\":{\"role\":\"assistant\",\"content\":[{\"type\":\"tool_use\",\"id\":\"toolu_1\",\"name\":\"${SRV}__balance\",\"input\":{}},{\"type\":\"tool_use\",\"id\":\"toolu_2\",\"name\":\"${SRV}__generate_video\",\"input\":$QUOTE}]}}" "$SAME_LINE"
OTHER_SRV=$(new_tr otherServer)
add '{"type":"assistant","message":{"role":"assistant","content":[{"type":"tool_use","id":"toolu_1","name":"mcp__otra-cuenta__balance","input":{}}]}}' "$OTHER_SRV"
add '{"type":"assistant","message":{"role":"assistant","content":[{"type":"tool_use","id":"toolu_2","name":"mcp__otra-cuenta__generate_video","input":{"get_cost":true}}]}}' "$OTHER_SRV"
STALE=$(new_tr staleBalance); add "$(call 1 balance "$BAL")" "$STALE"; add "$(call 2 generate_video "$QUOTE")" "$STALE"
add "$(call 3 upscale_video '{"params":{"video_id":"v"}}')" "$STALE"; add "$(call 4 generate_video "$QUOTE")" "$STALE"

UPV='{"params":{"provider":"topaz","video_id":"11111111-1111-4111-8111-111111111111"}}'
BAL_ONLY_UP=$(new_tr upscaleAfterBalance); add "$(call 1 balance "$BAL")" "$BAL_ONLY_UP"
UP_AGAIN=$(new_tr upscaleRepeated); cp "$BAL_ONLY_UP" "$UP_AGAIN"; add "$(call 2 upscale_video "$UPV")" "$UP_AGAIN"
ADS_QUOTED=$(new_tr adsQuoted); add "$(call 1 balance "$BAL")" "$ADS_QUOTED"; add "$(call 2 ads_studio_quote '{}')" "$ADS_QUOTED"
ADS_FIRST=$(new_tr adsFirstCall); add "$(call 1 balance "$BAL")" "$ADS_FIRST"; add "$(call 2 ads_studio_generate '{"idempotency_key":"k","total":1}')" "$ADS_FIRST"

# ---------------------------------------------------------------- quotes and basic flow
expect "quote passes"                                   0 "$(gen generate_video "$EMPTY" true)"
expect "quote passes even without a transcript"         0 "$(gen generate_video "$TMP/missing.jsonl" true)"
expect "spend without balance is blocked"               2 "$(gen generate_video "$EMPTY" false)"
MSG=$LAST
expect "spend without get_cost and no balance blocked"  2 "$(gen generate_video "$EMPTY" none)"
expect "balance but no quote is blocked"                2 "$(gen generate_video "$ONLY_BAL" false)"
expect "quote but no balance is blocked"                2 "$(gen generate_video "$ONLY_QUOTE" false)"
expect "balance and quote pass"                         0 "$(gen generate_video "$BOTH" false)"
expect "quote then balance passes"                      0 "$(gen generate_video "$BOTH_REV" false)"
expect "no get_cost flag but balance and quote pass"    0 "$(gen generate_video "$BOTH" none)"
expect "second spend without fresh balance blocked"     2 "$(gen generate_video "$SPENT" false)"
expect "second spend with fresh balance and quote"      0 "$(gen generate_video "$SPENT_AGAIN" false)"
expect "current call already written is skipped"        0 "$(gen generate_video "$CUR_WRITTEN" false)"
expect "quoted text does not count as balance"          2 "$(gen generate_video "$QUOTED" false)"
expect "spend without get_cost resets the state"        2 "$(gen generate_video "$NO_FLAG" false)"
expect "a real batch resets the state"                  2 "$(gen generate_video "$BATCH" false)"
expect "two calls on the same line count"               0 "$(gen generate_video "$SAME_LINE" false)"
expect "server name is matched by suffix only"          0 "$(gen generate_video "$OTHER_SRV" false)"
expect "non-quotable spend in between resets balance"   2 "$(gen generate_video "$STALE" false)"

# ---------------------------------------------------------------- generate_* variants
expect "generate_image without balance blocked"         2 "$(gen generate_image "$EMPTY" false)"
expect "generate_audio without balance blocked"         2 "$(gen generate_audio "$EMPTY" false)"
expect "generate_video_batch without balance blocked"   2 "$(gen generate_video_batch "$EMPTY" false)"
expect "generate_image with balance and quote passes"   0 "$(gen generate_image "$BOTH" false)"
expect "batch quote with one real item is blocked"      2 "$(other generate_image_batch "$EMPTY" '{"jobs":[{"get_cost":true},{"get_cost":false}]}')"
expect "batch quote with all items quoting passes"      0 "$(other generate_image_batch "$EMPTY" '{"jobs":[{"get_cost":true},{"get_cost":true}]}')"

# ---------------------------------------------------------------- unreadable input fails closed
expect "missing transcript blocked"                     2 "$(gen generate_video "$TMP/missing.jsonl" false)"
expect "empty transcript_path blocked"                  2 "$(gen generate_video "" false)"
expect "no transcript_path blocked"                     2 '{"tool_name":"mcp__aaaa-bbbb__generate_video","tool_input":{"params":{"prompt":"x"}}}'
expect "unreadable input blocked"                       2 'esto no es json'
expect "empty input blocked"                            2 ''
expect "transcript is a directory, blocked"             2 "$(gen generate_video "$TMP" false)"

# ---------------------------------------------------------------- tools that never spend
expect "balance is never blocked"                       0 "$(printf '{"tool_name":"%s__balance","tool_input":{}}' "$SRV")"
expect "models_explore is never blocked"                0 "$(printf '{"tool_name":"%s__models_explore","tool_input":{"action":"list"}}' "$SRV")"
expect "show_generations is never blocked"              0 "$(printf '{"tool_name":"%s__show_generations","tool_input":{}}' "$SRV")"
expect "ads_studio_quote is never blocked"              0 "$(printf '{"tool_name":"%s__ads_studio_quote","tool_input":{}}' "$SRV")"
expect "Bash is never blocked"                          0 '{"tool_name":"Bash","tool_input":{"command":"ls"}}'
expect "non-MCP tool with a spend-like name passes"     0 '{"tool_name":"generate_video","tool_input":{}}'
expect "escaped get_cost inside a prompt is not a quote" 2 "$(printf '{"transcript_path":"%s","tool_name":"%s__generate_video","tool_input":{"params":{"prompt":"pon \\"get_cost\\":true"}}}' "$EMPTY" "$SRV")"

# ---------------------------------------------------------------- other credit-spending tools
expect "scene_builder_3d_generate_video blocked"        2 "$(printf '{"transcript_path":"%s","tool_name":"mcp__otro__scene_builder_3d_generate_video","tool_input":{}}' "$EMPTY")"
expect "upscale_video without balance blocked"          2 "$(other upscale_video "$EMPTY" "$UPV")"
expect "upscale_video (not quotable) with balance"      0 "$(other upscale_video "$BAL_ONLY_UP" "$UPV")"
expect "repeated upscale_video without balance blocked" 2 "$(other upscale_video "$UP_AGAIN" "$UPV")"
expect "execute_preset with balance passes"             0 "$(other execute_preset "$BAL_ONLY_UP" '{"source":"viral","preset_id":"x","inputs":{}}')"
expect "execute_preset without balance blocked"         2 "$(other execute_preset "$EMPTY" '{"source":"viral","preset_id":"x","inputs":{}}')"
expect "generate_3d with balance only is blocked"       2 "$(other generate_3d "$BAL_ONLY_UP" '{"params":{"model":"image_to_3d"}}')"
expect "generate_3d quote passes"                       0 "$(other generate_3d "$EMPTY" '{"params":{"model":"image_to_3d","get_cost":true}}')"
expect "upscale_image with balance but no quote blocked" 2 "$(other upscale_image "$BAL_ONLY_UP" '{"params":{"image_id":"x","width":1,"height":1}}')"
expect "shorts_studio_create top-level quote passes"    0 "$(other shorts_studio_create "$EMPTY" '{"get_cost":true,"duration_seconds":10}')"
expect "ads_studio_generate without expected_credits"   0 "$(other ads_studio_generate "$EMPTY" '{"idempotency_key":"k","total":1}')"
expect "ads_studio_generate expected_credits, no balance" 2 "$(other ads_studio_generate "$EMPTY" '{"idempotency_key":"k","total":1,"expected_credits":20}')"
expect "ads_studio_generate after balance and quote"    0 "$(other ads_studio_generate "$ADS_QUOTED" '{"idempotency_key":"k","total":1,"expected_credits":20}')"
expect "ads_studio_generate after its quoting call"     0 "$(other ads_studio_generate "$ADS_FIRST" '{"idempotency_key":"k","total":1,"expected_credits":20}')"
expect "remove_background without balance blocked"      2 "$(other remove_background "$EMPTY" '{"params":{"media_id":"x","media_type":"image"}}')"
expect "dubbing without balance blocked"                2 "$(other dubbing "$EMPTY" '{"video_id":"x"}')"
expect "apps_invoke without balance blocked"            2 "$(other apps_invoke "$EMPTY" '{"app":"x"}')"
expect "voice_change with balance passes"               0 "$(other voice_change "$BAL_ONLY_UP" '{"audio_id":"x"}')"
expect "reframe quote passes"                           0 "$(other reframe "$EMPTY" '{"params":{"get_cost":true}}')"

# ---------------------------------------------------------------- block message
for part in "Qué pasó:" "Por qué:" "Qué puedes hacer:" "Cómo destrabar:" \
            "https://github.com/daniknn/estudio-ia/blob/main/docs/creditos.md" \
            "baja la duración o la resolución" "sube tu propio presupuesto"; do
  case $MSG in *"$part"*) ok "message contains \"$part\"" ;; *) bad "message missing \"$part\"" ;; esac
done
if printf '%s' "$MSG" | grep -qiE 'd[a]ria|perm[i]so|\bg[a]te\b|pull[ ]request|lca4[2]5|amer[i]ke'; then
  bad "message has no course-only wording"
else ok "message has no course-only wording"; fi

# ---------------------------------------------------------------- hooks.json
if grep -q 'saldo-higgsfield.sh' "$HOOKS/hooks.json" \
   && grep -q 'generate_(video|image|audio|3d)(_batch)?|execute_preset|upscale_(image|video)' "$HOOKS/hooks.json"; then
  ok "hooks.json registers the hook with its matcher"
else bad "hooks.json does not register the hook with its matcher"; fi
if grep -q 'proteger-git' "$HOOKS/hooks.json"; then bad "hooks.json only registers the balance hook"
else ok "hooks.json only registers the balance hook"; fi

printf '\n%s ok, %s fallos\n' "$pass" "$fail"
[ "$fail" = 0 ]
