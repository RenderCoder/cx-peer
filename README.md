# cx-peer

本机 Codex CLI 的只读同伴技能。从 `codex-consult` 迁出，独立成仓。

| 指令 | 做什么 |
| --- | --- |
| `/cx-peer` | 咨询、冻结唯一推荐。最多 3 轮观点。 |
| `/cx-peer-loop` | 审核产物（代码 / 文档 / 计划），宿主按评审修改后再送审，直到通过。默认最多 20 轮。 |

Codex 不改仓库。运行技能的一方落地修改。

## 安装

```bash
git clone git@github.com:RenderCoder/cx-peer.git
bash cx-peer/scripts/install.sh
```

把本仓链到 `~/.agents/skills/cx-peer` 与 `~/.claude/skills/cx-peer`，并把 `aliases/cx-peer-loop` 链到同名技能。不要再链到 `~/.grok/skills` 或 `~/.codex/skills`（同名会重复注册）。

Grok 在仓内还会扫 `.agents/skills`，装完后用 `/cx-peer` 或 `/cx-peer-loop`。

## 项目内文件

技能在**被审项目根**写 `.cx-peer/`：

- `config.json`：项目级 `max_rounds`（只约束闭环；缺省 20）。用户说「上限改成 N」时写入。
- `sessions/<stamp>-<mode>-<topic>/`：每轮提问、Codex 原文、裁决。机器底稿在 session 的 `scratch/`（由 `.cx-peer/.gitignore` 忽略）。

## 默认模型

`gpt-5.6-sol`，`model_reasoning_effort=xhigh`，首轮 `read-only`。细节在 `references/cli.md`。

## 来源

协议沿用 mes-factory-kit 仓内 `codex-consult` 与 ADR-0016。本仓是此后的维护位置。
