# CLI 协议

本机 `codex exec`。v1 不写包装脚本。命令从**被审项目根**运行。

被审目录是 Git 仓库时，默认不要 `--skip-git-repo-check`。不是 Git 仓库时，首轮和每一次 `resume` 都必须带 `--skip-git-repo-check`。

模型与思考深度见 [effort.md](effort.md)。下列命令里的 `<effort>` 按该表解析。

## 默认

- 沙箱：首轮 `-s read-only`；`resume` **不要** `-s`
- 禁止：`--ephemeral`、`--last`、`fork`（失败恢复和普通续轮）、`--output-schema`、实验 `--enable`、`--approve-for-me`、`--dangerously-bypass-approvals-and-sandbox`
- 不要用 `omx ask` / MCP 冒充本技能
- 即使当前宿主已经是 Codex，也必须另开独立的 `codex exec` 进程做评审；不要在本会话里自己审自己。同伴进程不要再调用本技能

`--approve-for-me` 会改用 `workspace-write`；`--dangerously-bypass-approvals-and-sandbox` 会绕过沙箱。二者都破坏只读契约。

## 路径占位

下列命令里的文件都落在当前 session 目录（见 [records.md](records.md)）。`<prompt>` `<out>` `<jsonl>` `<err>` 每次 attempt 独立，禁止复用失败 attempt 的 `-o`。非 Git 仓库时在 `codex exec` 与 `codex exec resume` 上都加上 `--skip-git-repo-check`。

## 首轮

```bash
codex exec -s read-only -m gpt-6.1-sol -c model_reasoning_effort="<effort>" --json -o <out> - < <prompt> > <jsonl> 2> <err>
```

从**这份** JSONL 取 `thread.started.thread_id`。成功 = 这份 JSONL 出现 `turn.completed`，且读的是这份 `-o`。不要用包装脚本或 shell 退出码当成败（zsh 里 `status` 是只读变量）。

## 传输失败后 resume

仅当已经有 `thread_id` 且出现 `turn.failed`（含代理 503/502）。恢复提示要短，不要整篇重灌原始 prompt。每轮最多两次外层 resume（合计三个 attempt）。无 thread id：修正启动问题后重新首轮。

```bash
printf '%s\n' '继续完成上一轮请求，约束不变。' | codex exec resume <thread_id> -m gpt-6.1-sol -c model_reasoning_effort="<effort>" --json -o <out> - > <jsonl> 2> <err>
```

## 同一 thread 的下一观点轮

新提示词文件，attempt 从该轮 `a1` 起。`resume` 不要 `-s`。

```bash
codex exec resume <thread_id> -m gpt-6.1-sol -c model_reasoning_effort="<effort>" --json -o <out> - < <prompt> > <jsonl> 2> <err>
```

## 提示词最低内容

角色、只读范围、脏工作区里要忽略的路径、要求相对路径、要冻结或裁决的问题、输出格式。提示词走文件或 stdin（`… - < file`），不要塞超长 argv。

Codex **不改仓库、不给补丁、不把伪代码当实现**。主助手写后续改动。

## 坑

- `resume` 子命令没有 `--sandbox`。带 `-s` 会直接失败；thread 还在，去掉再 resume。
- 代理 5 次重连失败后是 `turn.failed`，不是「无输出」。外层用短提示 `resume`，不新开 thread。
- 不要 `Read` 整份 JSONL（可超 1MB）。给人看的正文用该 attempt 的 `-o`。
- 原文区不得静默改写绝对路径；需要说明或脱敏时另加标注。
