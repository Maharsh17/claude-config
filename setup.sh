#!/usr/bin/env bash
# Installs the skill stack, then copies this config into ~/.claude.
# Anything it replaces is backed up to ~/.claude/backup-<timestamp>/ first.
# Usage: bash setup.sh            (stack + config)
#        bash setup.sh --config   (config only, skip installing the stack)
set -eu
cd "$(dirname "$0")"

[ "${1:-}" = "--config" ] || bash install-stack.sh || echo "stack had failures, continuing with config"

C="$HOME/.claude"
B="$C/backup-$(date +%Y%m%d-%H%M%S)"
MEM="$C/projects/$(printf %s "$HOME" | sed 's/[^A-Za-z0-9]/-/g')/memory" # memory for sessions started in ~

put() { # usage: put <source> <dest>
  if [ -e "$2" ] && ! diff -rq "$1" "$2" >/dev/null 2>&1; then
    mkdir -p "$B" && cp -R "$2" "$B/" && echo "backed up $2"
  fi
  mkdir -p "$(dirname "$2")" && rm -rf "$2" && cp -R "$1" "$2"
}

put claude/CLAUDE.md               "$C/CLAUDE.md"
put claude/settings.json           "$C/settings.json"
put claude/statusline-command.sh   "$C/statusline-command.sh"
put claude/skills/no-ai-slop       "$C/skills/no-ai-slop"
for f in memory/*.md; do put "$f" "$MEM/$(basename "$f")"; done
touch "$C/.i-have-adhd-always" # action-first replies in every session; delete to turn off

echo "Config installed. Restart Claude Code."
