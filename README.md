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

把仓内 `cx-peer/` 与 `cx-peer-loop/` 链成四个 skills 根下的同级目录：`~/.agents/skills`、`~/.claude/skills`、`~/.grok/skills`（Grok Build）、`${CODEX_HOME:-~/.codex}/skills`（Codex CLI）。不要把仓根链成技能（会把别名嵌进去）。安装器若发现目标已被其它路径占用会报路径并停止；仅当旧链接已指向本仓时才改过来。

装完后 Grok Build 与 Codex CLI 都用 `/cx-peer` 或 `/cx-peer-loop`。

## 项目内文件

技能在**被审项目根**写 `.cx-peer/`：

- `config.json`：项目级 `max_rounds`（只约束闭环；缺省 20）。用户说「上限改成 N」时写入。
- `sessions/<stamp>-<mode>-<topic>/`：每轮提问、Codex 原文、裁决。机器底稿在 session 的 `scratch/`（由 `.cx-peer/.gitignore` 忽略）。

## 默认模型

`gpt-5.6-sol`，`model_reasoning_effort=xhigh`，首轮 `read-only`。细节在 `cx-peer/references/cli.md`。

## 来源

协议沿用 mes-factory-kit 仓内 `codex-consult` 与 ADR-0016。本仓是此后的维护位置。
