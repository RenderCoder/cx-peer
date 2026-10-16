---
name: cx-peer-loop-low
description: >
  Review an artifact with local Codex CLI using gpt-6.1-sol and
  model_reasoning_effort=low, then have the host fix and resubmit
  until Codex passes. Use when the user runs /cx-peer-loop-low. Requires the
  sibling cx-peer skill. Do not use when the current host is already Codex.
---

# cx-peer-loop-low

Thin alias. Loop mode with `model_reasoning_effort=low`.

Read and follow:

- `../cx-peer/SKILL.md`
- `../cx-peer/references/cli.md`
- `../cx-peer/references/effort.md`
- `../cx-peer/references/records.md`
- `../cx-peer/references/loop.md`

Use `-c model_reasoning_effort="low"` on every `codex exec` and `resume`. Do not run consult mode.
