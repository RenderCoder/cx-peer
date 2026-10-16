---
name: cx-peer-loop-medium
description: >
  Review an artifact with local Codex CLI using gpt-6.1-sol and
  model_reasoning_effort=medium, then have the host fix and resubmit
  until Codex passes. Use when the user runs /cx-peer-loop-medium. Requires the
  sibling cx-peer skill. Always spawn a separate `codex exec` process, even when the host is already Codex.
---

# cx-peer-loop-medium

Thin alias. Loop mode with `model_reasoning_effort=medium`.

Read and follow:

- `../cx-peer/SKILL.md`
- `../cx-peer/references/cli.md`
- `../cx-peer/references/effort.md`
- `../cx-peer/references/records.md`
- `../cx-peer/references/loop.md`

Use `-c model_reasoning_effort="medium"` on every `codex exec` and `resume`. Do not run consult mode.
