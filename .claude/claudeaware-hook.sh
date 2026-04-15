#!/bin/bash
# ClaudeAware hook script — managed by the ClaudeAware VS Code extension.
# Do not edit manually; this file is overwritten on extension activation.
#
# Usage: claudeaware-hook.sh begin-edit
#        claudeaware-hook.sh end-edit
#
# Reads Claude Code's hook JSON from stdin and POSTs it to the local
# ClaudeAware server. Always exits 0. Never blocks. Never writes to stderr.

EVENT="$1"  # "begin-edit" or "end-edit"

DIR="$(dirname "$0")"
PORT_FILE="$DIR/claudeaware-port"
TOKEN_FILE="$DIR/claudeaware-token"

# Server not running — fail open silently.
if [ ! -f "$PORT_FILE" ] || [ ! -f "$TOKEN_FILE" ]; then
  cat > /dev/null  # drain stdin so Claude Code doesn't block
  exit 0
fi

PORT=$(cat "$PORT_FILE")
TOKEN=$(cat "$TOKEN_FILE")

# Capture stdin (Claude Code's JSON payload) and POST it.
# We don't care about the response body or status — fire and forget.
curl -s -o /dev/null \
  -X POST "http://127.0.0.1:${PORT}/${EVENT}" \
  -H 'Content-Type: application/json' \
  -H "X-Claudeaware-Token: ${TOKEN}" \
  --data-binary @- \
  --max-time 2 \
  2>/dev/null || true

exit 0
