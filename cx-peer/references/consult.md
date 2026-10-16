# `/cx-peer` 咨询

只读架构/设计咨询。对人交付「讨论归档 + 冻结项」。观点轮次一轮起步、最多三轮；传输重试不计入。第三轮后仍未冻结则记录未决并交回机主。

每轮唯一推荐；禁止补丁 / 伪代码当实现。未拍板前不要把冻结项写成已实施。

## 步骤

1. 按 [records.md](records.md) 开 session（`mode=consult`）。写 `SESSION.md` 提问原文。
2. 本轮提示词写入 `rNN/prompt.md`。输出格式：摘要 → 唯一推荐 → 边界 → 不要做什么 → 未决。
3. 按 [cli.md](cli.md) 跑首轮或 `resume`。stdout/stderr/`-o` 进 `scratch/`，成功后把 `-o` 拷到 `rNN/review.md`，填 `rNN/meta.md`。
4. 改冻结项时写明改了上一轮哪几条。
5. 更新 `SESSION.md`。

完成：每轮都有提问原文与 Codex 原文；thread id 可核对；没有把 `-s` 传给 `resume`；没有把失败 attempt 的旧 `-o` 当成成功。
