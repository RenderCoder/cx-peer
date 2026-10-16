---
name: cx-peer-loop
description: >
  Review an artifact with local Codex CLI, then have the host agent fix and
  resubmit until Codex passes. Use when the user runs /cx-peer-loop, asks
  to iterate review until pass, or wants Codex to审核代码/文档/计划并反复修改
  (cx-peer-loop, 审核直到通过, 反复送审). Requires the sibling cx-peer skill.
  Do not use when the current host is already Codex.
---

# cx-peer-loop

薄别名。按闭环模式跑兄技能 `cx-peer`。

## 定位主技能

本目录安装在 skills 根下的 `cx-peer-loop`。主技能目录是同一根下的 `cx-peer`。读取并遵循：

- `../cx-peer/SKILL.md`
- `../cx-peer/references/cli.md`
- `../cx-peer/references/records.md`
- `../cx-peer/references/loop.md`

然后执行闭环，不要走咨询模式。
