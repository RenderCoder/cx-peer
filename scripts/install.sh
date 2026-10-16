#!/usr/bin/env bash
set -euo pipefail

SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
AGENTS="${HOME}/.agents/skills"
CLAUDE="${HOME}/.claude/skills"
PEER_SRC="${SOURCE}/cx-peer"
LOOP_SRC="${SOURCE}/cx-peer-loop"

usage() {
  printf '%s\n' "Usage: bash scripts/install.sh" "Links cx-peer and cx-peer-loop into ~/.agents/skills and ~/.claude/skills."
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
  case "$resolved" in
    "$SOURCE"|"${SOURCE}/cx-peer"|"${SOURCE}/cx-peer-loop"|"${SOURCE}/aliases/cx-peer-loop")
      return 0
      ;;
  esac
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

[[ -f "${PEER_SRC}/SKILL.md" && -f "${LOOP_SRC}/SKILL.md" ]] || {
  printf 'install.sh: missing skill files under %s\n' "$SOURCE" >&2
  exit 1
}

mkdir -p "$AGENTS" "$CLAUDE"

prepare_dest "${AGENTS}/cx-peer"
prepare_dest "${AGENTS}/cx-peer-loop"
prepare_dest "${CLAUDE}/cx-peer"
prepare_dest "${CLAUDE}/cx-peer-loop"

ln -sfn "$PEER_SRC" "${AGENTS}/cx-peer"
ln -sfn "$LOOP_SRC" "${AGENTS}/cx-peer-loop"
ln -sfn "$PEER_SRC" "${CLAUDE}/cx-peer"
ln -sfn "$LOOP_SRC" "${CLAUDE}/cx-peer-loop"

printf '%s\n' \
  "cx-peer -> ${PEER_SRC}" \
  "cx-peer-loop -> ${LOOP_SRC}" \
  "linked from ${AGENTS} and ${CLAUDE}"
