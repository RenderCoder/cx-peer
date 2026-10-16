#!/usr/bin/env bash
set -euo pipefail

SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"

ROOTS=(
  "${HOME}/.agents/skills"
  "${HOME}/.claude/skills"
  "${HOME}/.grok/skills"
  "${CODEX_HOME}/skills"
)

usage() {
  printf '%s\n' "Usage: bash scripts/install.sh" \
    "Links every in-repo skill directory into ~/.agents/skills, ~/.claude/skills, ~/.grok/skills, and \${CODEX_HOME:-~/.codex}/skills."
}

physical_join() {
  local path="$1"
  local prefix leaf
  path="${path%/}"
  if [[ -d "$path" ]]; then
    (cd "$path" && pwd -P)
    return
  fi
  if [[ "$path" != /* ]]; then
    printf 'install.sh: expected absolute path, got %s\n' "$path" >&2
    return 1
  fi
  prefix="$path"
  leaf=""
  while [[ ! -d "$prefix" ]]; do
    if [[ "$prefix" == "/" ]]; then
      printf '%s\n' "$path"
      return
    fi
    if [[ -n "$leaf" ]]; then
      leaf="${prefix##*/}/${leaf}"
    else
      leaf="${prefix##*/}"
    fi
    prefix="${prefix%/*}"
    [[ -n "$prefix" ]] || prefix="/"
  done
  printf '%s/%s\n' "$(cd "$prefix" && pwd -P)" "$leaf"
}

link_target_abs() {
  local dest="$1"
  local target dir
  target="$(readlink "$dest")"
  if [[ "$target" != /* ]]; then
    dir="$(cd "$(dirname "$dest")" && pwd -P)"
    target="${dir}/${target}"
  fi
  physical_join "$target"
}

ours_link() {
  local dest="$1"
  local resolved
  [[ -L "$dest" ]] || return 1
  resolved="$(link_target_abs "$dest")"
  if [[ "$resolved" == "$SOURCE" || "$resolved" == "${SOURCE}/aliases/cx-peer-loop" ]]; then
    return 0
  fi
  if [[ "$resolved" == "$SOURCE"/* && -f "${resolved}/SKILL.md" ]]; then
    return 0
  fi
  return 1
}

prepare_dest() {
  local dest="$1"
  if [[ ! -e "$dest" && ! -L "$dest" ]]; then
    return 0
  fi
  if ours_link "$dest"; then
    return 0
  fi
  printf 'install.sh: refusing to replace %s\n' "$dest" >&2
  ls -ld "$dest" >&2
  exit 1
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

SKILLS=()
shopt -s nullglob
for skill_md in "$SOURCE"/*/SKILL.md; do
  SKILLS+=("$(cd "$(dirname "$skill_md")" && pwd -P)")
done
[[ ${#SKILLS[@]} -gt 0 ]] || {
  printf 'install.sh: no skill directories under %s\n' "$SOURCE" >&2
  exit 1
}

for root in "${ROOTS[@]}"; do
  mkdir -p "$root"
  for src in "${SKILLS[@]}"; do
    name="$(basename "$src")"
    prepare_dest "${root}/${name}"
    ln -sfn "$src" "${root}/${name}"
  done
done

for src in "${SKILLS[@]}"; do
  printf '%s -> %s\n' "$(basename "$src")" "$src"
done
for root in "${ROOTS[@]}"; do
  printf 'linked %s\n' "$root"
done
