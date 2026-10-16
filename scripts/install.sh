#!/usr/bin/env bash
set -euo pipefail

SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AGENTS="${HOME}/.agents/skills"
CLAUDE="${HOME}/.claude/skills"

mkdir -p "$AGENTS" "$CLAUDE"
ln -sfn "$SOURCE" "${AGENTS}/cx-peer"
ln -sfn "${SOURCE}/aliases/cx-peer-loop" "${AGENTS}/cx-peer-loop"
ln -sfn "$SOURCE" "${CLAUDE}/cx-peer"
ln -sfn "${SOURCE}/aliases/cx-peer-loop" "${CLAUDE}/cx-peer-loop"

printf '%s\n' \
  "cx-peer -> ${SOURCE}" \
  "cx-peer-loop -> ${SOURCE}/aliases/cx-peer-loop" \
  "linked from ${AGENTS} and ${CLAUDE}"
