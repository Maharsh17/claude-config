#!/bin/sh
# Claude Code statusLine - mirrors Powerlevel10k orange/black bar theme
# Segments: user@macbook | dir | git branch | model | context%  ||  time

input=$(cat)

# ---------- data from Claude ----------
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
repo_name=$(echo "$input" | jq -r '.workspace.repo | if . then .owner + "/" + .name else empty end')

# ---------- derived values ----------
user=$(whoami)
dir="${cwd:-$(pwd)}"
# shorten home prefix
dir="${dir/#$HOME/~}"
# show only last 2 path components if long
short_dir=$(echo "$dir" | awk -F'/' '{if(NF>3) print "…/" $(NF-1) "/" $NF; else print $0}')

# git branch (skip optional lock with GIT_OPTIONAL_LOCKS=0)
git_branch=""
if [ -n "$cwd" ]; then
  git_branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null)
fi

# context badge
ctx_badge=""
if [ -n "$used_pct" ]; then
  used_int=$(printf '%.0f' "$used_pct")
  ctx_badge="${used_int}% used"
fi

# ---------- ANSI colors (256-color) ----------
# orange=208, bright_orange=214, dim_orange=130, deep_orange=166, black=232
ORG='\033[38;5;208m'      # orange fg
BORG='\033[38;5;214m'     # bright orange fg
DORG='\033[38;5;130m'     # dim orange fg
DEORG='\033[38;5;166m'    # deep orange fg
BLK='\033[38;5;232m'      # near-black fg (unused on dark bg here)
RESET='\033[0m'

# Build status line
line=""

# user@macbook segment (deep orange)
line="${line}$(printf "${DEORG}%s@macbook${RESET}" "$user")"

# separator
line="${line}$(printf "${DORG} | ${RESET}")"

# dir segment (orange)
line="${line}$(printf "${ORG}%s${RESET}" "$short_dir")"

# git branch (bright orange)
if [ -n "$git_branch" ]; then
  line="${line}$(printf "${DORG} | ${BORG} %s${RESET}" "$git_branch")"
elif [ -n "$repo_name" ]; then
  line="${line}$(printf "${DORG} | ${BORG}%s${RESET}" "$repo_name")"
fi

# model (dim orange)
if [ -n "$model" ]; then
  line="${line}$(printf "${DORG} | %s${RESET}" "$model")"
fi

# context usage
if [ -n "$ctx_badge" ]; then
  line="${line}$(printf "${DORG} [%s]${RESET}" "$ctx_badge")"
fi

# time (bright orange, right-leaning via spacing)
time_str=$(date +%H:%M:%S)
line="${line}$(printf "  ${BORG}%s${RESET}" "$time_str")"

printf "%b\n" "$line"
