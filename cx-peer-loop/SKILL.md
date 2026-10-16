---
name: cx-peer-loop
description: >
  Review an artifact with local Codex CLI (gpt-6.1-sol, high), then have the
  host agent fix and resubmit until Codex passes. Use when the user runs
  /cx-peer-loop, asks to iterate review until pass, or wants Codex to审核代码/
  文档/计划并反复修改 (cx-peer-loop, 审核直到通过, 反复送审). Effort variants
  are /cx-peer-loop-low through /cx-peer-loop-ultra. Requires the sibling
  cx-peer skill. Always spawn a separate `codex exec` process, even when
  the host is already Codex.
---

# cx-peer-loop

薄别名。按闭环模式跑兄技能 `cx-peer`。默认 `model_reasoning_effort=high`。

## 定位主技能

本目录安装在 skills 根下的 `cx-peer-loop`。主技能目录是同一根下的 `cx-peer`。读取并遵循：

- `../cx-peer/SKILL.md`
- `../cx-peer/references/cli.md`
- `../cx-peer/references/effort.md`
- `../cx-peer/references/records.md`
- `../cx-peer/references/loop.md`

然后执行闭环，不要走咨询模式。
