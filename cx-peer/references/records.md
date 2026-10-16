# 项目目录约定

记录与配置都写在**当前被审项目**根目录的 `.cx-peer/`，不写进技能仓，不写 `docs/adr/` 充当唯一归档。

项目根：当前 git 仓库根；无 git 时用宿主工作目录。无 git 时的 CLI 标志见 [cli.md](cli.md)。

## 配置

路径：`.cx-peer/config.json`

```json
{
  "max_rounds": 20
}
```

- `max_rounds` 只约束 `/cx-peer-loop` 的观点轮次。传输重试不计入。
- 文件缺失或字段缺失时当 `20`。
- 值必须是 JSON 整数且 `>= 1`。JSON 损坏、类型不对或越界：停止闭环，向用户报告配置错误，不要静默回退、不要开跑。
- 用户声明新的上限（「上限改成 N」「最多 N 轮」）：写入该文件并本会话生效。写入前同样校验。
- 用户声明仅本轮（「这次 N 轮」）：本会话用 N，不改文件。N 必须 `>= 1` 的整数。
- `SESSION.md` 必须写明本会话**实际生效**的 `max_rounds`。

咨询模式 `/cx-peer` 的观点轮次上限是技能内固定的 3，不受此字段约束。

## `.gitignore`

每次使用 `.cx-peer/` 之前，幂等确保 `.cx-peer/.gitignore` 含有一条有效的 `scratch/` 规则（单独一行 `scratch/`）。文件不存在则创建；已存在但缺该规则则追加。不要覆盖文件里的其它行。

## Session 目录

`.cx-peer/sessions/<stamp>-<mode>-<topic>/`

- `stamp`：本地时间 `YYYYMMDD-HHMMSS`
- `mode`：`consult` 或 `loop`
- `topic`：短 slug（小写、数字、连字符）

创建必须原子：`mkdir` 目标路径，已存在则失败。同秒、同模式、同 topic 冲突时在末尾追加 `-2`、`-3`… 再 `mkdir`，直到成功。禁止复用或覆盖已有 session 目录。

```
SESSION.md
r01/prompt.md
r01/review.md
r01/meta.md
scratch/r01-a1.jsonl
scratch/r01-a1.err
scratch/r01-a1-last.md
```

`review.md` 是成功 attempt 的 `-o` 原文拷贝。`scratch/` 里保留机器底稿。

## SESSION.md

开场先写提问意图、产物类型（loop 必填）、实际生效的 `max_rounds`、thread id（有则补）。每轮追加一行：轮次、裁决或结论、指向 `rNN/review.md`。结束时写状态：`通过` / `未决` / `达上限` / `中止`。

## rNN/meta.md

- thread id
- 每个 attempt 的文件名（a1/a2/a3，以及补裁决 attempt）
- 成功依据：该 JSONL 含 `turn.completed`
- loop：按 [loop.md](loop.md) 解析出的裁决（`通过` / `不通过` / `无有效裁决`）
