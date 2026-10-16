---
name: cx-peer-loop-high
description: >
  Review an artifact with local Codex CLI using gpt-6.1-sol and
  model_reasoning_effort=high, then have the host fix and resubmit
  until Codex passes. Use when the user runs /cx-peer-loop-high. Requires the
  sibling cx-peer skill. Always spawn a separate `codex exec` process, even when the host is already Codex.
---

# cx-peer-loop-high

Thin alias. Loop mode with `model_reasoning_effort=high`.

Read and follow:

- `../cx-peer/SKILL.md`
- `../cx-peer/references/cli.md`
- `../cx-peer/references/effort.md`
- `../cx-peer/references/records.md`
- `../cx-peer/references/loop.md`

Use `-c model_reasoning_effort="high"` on every `codex exec` and `resume`. Do not run consult mode.
