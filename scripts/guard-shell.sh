#!/usr/bin/env bash
# PreToolUse guard. Kiro sends the session context as JSON on stdin and blocks
# the tool call when this script exits non-zero.
#
# Deliberately blunt: a training example, not a security product. A determined
# agent can phrase a command around any pattern list. Treat it as a seatbelt.
set -uo pipefail

payload="$(cat)"

patterns=(
  'rm[[:space:]]+-rf[[:space:]]+/'
  'git[[:space:]]+push[[:space:]].*--force'
  'DROP[[:space:]]+(TABLE|DATABASE)'
  'kubectl[[:space:]]+delete[[:space:]]+(ns|namespace)'
  'terraform[[:space:]]+(apply|destroy)[[:space:]]+.*-auto-approve'
  'aws[[:space:]]+.*delete-'
  ':(){:|:&};:'
)

for p in "${patterns[@]}"; do
  if grep -Eqi "$p" <<<"$payload"; then
    echo "guard-shell: blocked - command matches the guarded pattern /$p/" >&2
    echo "If this is genuinely what you want, run it yourself in a terminal." >&2
    exit 1
  fi
done

exit 0
