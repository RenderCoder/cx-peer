---
name: cx-peer-loop-xhigh
description: >
  Review an artifact with local Codex CLI using gpt-6.1-sol and
  model_reasoning_effort=xhigh, then have the host fix and resubmit
  until Codex passes. Use when the user runs /cx-peer-loop-xhigh. Requires the
  sibling cx-peer skill. Do not use when the current host is already Codex.
---

# cx-peer-loop-xhigh

Thin alias. Loop mode with `model_reasoning_effort=xhigh`.

Read and follow:

- `../cx-peer/SKILL.md`
- `../cx-peer/references/cli.md`
- `../cx-peer/references/effort.md`
- `../cx-peer/references/records.md`
- `../cx-peer/references/loop.md`

Use `-c model_reasoning_effort="xhigh"` on every `codex exec` and `resume`. Do not run consult mode.
