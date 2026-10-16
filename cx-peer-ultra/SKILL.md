---
name: cx-peer-ultra
description: >
  Consult local Codex CLI as a read-only peer using gpt-6.1-sol and
  model_reasoning_effort=ultra. Use when the user runs /cx-peer-ultra.
  Always spawn a separate `codex exec` process, even when the host is already Codex.
---

# cx-peer-ultra

Thin alias. Consult mode with `model_reasoning_effort=ultra`.

Read and follow:

- `../cx-peer/SKILL.md`
- `../cx-peer/references/cli.md`
- `../cx-peer/references/effort.md`
- `../cx-peer/references/records.md`
- `../cx-peer/references/consult.md`

Use `-c model_reasoning_effort="ultra"` on every `codex exec` and `resume`. Do not run loop mode.
