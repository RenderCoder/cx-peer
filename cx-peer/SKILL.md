---
name: cx-peer
description: >
  Consult local Codex CLI as a read-only peer (gpt-6.1-sol, high). Use when
  the user runs /cx-peer for a design/architecture freeze, or /cx-peer-loop
  to review an artifact and iterate until Codex passes (咨询 Codex, 让 Codex 审,
  ask Codex, cx-peer-loop, 审核直到通过). Effort variants are /cx-peer-low
  through /cx-peer-ultra. Do not use when the current host is already Codex,
  or when the user only names a model/effort.
---

# cx-peer

本机 `codex exec` 只读同伴。主助手改产物；Codex 不改仓库。默认 `gpt-6.1-sol` + `high`。

先读 [references/cli.md](references/cli.md)、[references/effort.md](references/effort.md) 与 [references/records.md](references/records.md)。按调用名解析 effort，再按模式读一篇：

| 触发 | 模式 | 读 |
| --- | --- | --- |
| `/cx-peer` 及 `/cx-peer-{low,medium,high,xhigh,ultra}` | 咨询 | [references/consult.md](references/consult.md) |
| `/cx-peer-loop` 及 `/cx-peer-loop-{low,medium,high,xhigh,ultra}` | 闭环 | [references/loop.md](references/loop.md) |

用户同时说了咨询和闭环时走闭环。当前宿主已经是 Codex 时停止，不要递归。
