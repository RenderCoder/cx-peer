# Model and effort

- Model: `gpt-6.1-sol`
- Default effort for `/cx-peer` and `/cx-peer-loop`: `high`

Every `codex exec` and `resume` in a session uses the same model and effort. Do not mix efforts across rounds of one session.

## Commands

| Command | Mode | `model_reasoning_effort` |
| --- | --- | --- |
| `/cx-peer` | consult | `high` |
| `/cx-peer-low` | consult | `low` |
| `/cx-peer-medium` | consult | `medium` |
| `/cx-peer-high` | consult | `high` |
| `/cx-peer-xhigh` | consult | `xhigh` |
| `/cx-peer-ultra` | consult | `ultra` |
| `/cx-peer-loop` | loop | `high` |
| `/cx-peer-loop-low` | loop | `low` |
| `/cx-peer-loop-medium` | loop | `medium` |
| `/cx-peer-loop-high` | loop | `high` |
| `/cx-peer-loop-xhigh` | loop | `xhigh` |
| `/cx-peer-loop-ultra` | loop | `ultra` |

Resolve effort from the invoked skill/command name using this table. If the user names an effort in prose for a default command, use that effort for the session.

CLI flag: `-c model_reasoning_effort="<effort>"`.
