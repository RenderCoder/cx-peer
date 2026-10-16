# cx-peer

A read-only peer skill for the local Codex CLI.

| Command | What it does |
| --- | --- |
| `/cx-peer` | Consult and freeze a single recommendation. At most 3 viewpoint rounds. |
| `/cx-peer-loop` | Review an artifact (code, docs, or a plan). The host applies the review, then resubmits until Codex passes. Default cap is 20 rounds. |

Codex does not edit the repo. The agent that runs the skill applies changes.

## Install

```bash
git clone git@github.com:RenderCoder/cx-peer.git
bash cx-peer/scripts/install.sh
```

The installer links the in-repo `cx-peer/` and `cx-peer-loop/` directories as sibling skills under four roots: `~/.agents/skills`, `~/.claude/skills`, `~/.grok/skills` (Grok Build), and `${CODEX_HOME:-~/.codex}/skills` (Codex CLI). Do not link the repo root as a skill (that nests the alias). If a destination is already occupied by another path, the installer prints the path and stops. It only replaces a link that already points at this repo.

After install, Grok Build and Codex CLI both use `/cx-peer` or `/cx-peer-loop`.

## Project files

The skill writes `.cx-peer/` at the **root of the project under review**:

- `config.json`: project-level `max_rounds` (loop only; default 20). Persist a new cap when the user says to change the limit.
- `sessions/<stamp>-<mode>-<topic>/`: each round’s prompt, Codex reply, and verdict. Machine drafts live in that session’s `scratch/` (ignored by `.cx-peer/.gitignore`).

## Default model

`gpt-5.6-sol`, `model_reasoning_effort=xhigh`, first turn `read-only`. Details: `cx-peer/references/cli.md`.
