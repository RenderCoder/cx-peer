# 项目目录约定

记录与配置都写在**当前被审项目**根目录的 `.cx-peer/`，不写进技能仓，不写 `docs/adr/` 充当唯一归档。

项目根：当前 git 仓库根；无 git 时用宿主工作目录。

## 配置

路径：`.cx-peer/config.json`

```json
{
  "max_rounds": 20
}
```

- `max_rounds` 只约束 `/cx-peer-loop` 的观点轮次。传输重试不计入。
- 缺省文件或不含该字段时当 `20`。
- 用户声明新的上限（「上限改成 N」「最多 N 轮」）：写入该文件并本会话生效。
- 用户声明仅本轮（「这次 N 轮」）：本会话用 N，不改文件。

咨询模式 `/cx-peer` 的观点轮次上限是技能内固定的 3，不受此字段约束。

首次需要写记录时：若目录不存在则创建；若不存在 `.cx-peer/.gitignore` 则写入：

```
scratch/
```

这样 JSONL / stderr / 原始 `-o` 默认不入库；Markdown 记录默认可提交。

## Session 目录

`.cx-peer/sessions/<stamp>-<mode>-<topic>/`

- `stamp`：本地时间 `YYYYMMDD-HHMMSS`
- `mode`：`consult` 或 `loop`
- `topic`：短 slug（小写、数字、连字符）

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

开场先写提问意图、产物类型（loop 必填）、上限、thread id（有则补）。每轮追加一行：轮次、裁决或结论、指向 `rNN/review.md`。结束时写状态：`通过` / `未决` / `达上限` / `中止`。

## rNN/meta.md

- thread id
- attempt 文件名（a1/a2/a3）
- 成功依据：该 JSONL 含 `turn.completed`
- loop：从 `review.md` 抽出的裁决（`通过` / `不通过`）
