# claude-config

My Claude Code setup in one repo: global instructions, settings, status line, memory, and a stack of about twenty skill packs with a guide to which one to use when.

## Install

You need [Claude Code](https://claude.com/claude-code), Node 18+, git, [uv](https://docs.astral.sh/uv/) and `jq` (for the status line).

```bash
git clone https://github.com/Maharsh17/claude-config.git
cd claude-config
bash setup.sh            # skill stack + config
bash setup.sh --config   # config only, skip the skill stack
```

Restart Claude Code afterwards. Anything `setup.sh` replaces in `~/.claude` is backed up to `~/.claude/backup-<timestamp>/` first, and running it again changes nothing.

## What's in here

| Path | Goes to | What it is |
|---|---|---|
| `claude/CLAUDE.md` | `~/.claude/CLAUDE.md` | Global instructions for every session. No em dashes, write like a human, reproduce bugs end to end before fixing, fix lint and flaky tests on sight, ask before spawning a swarm of subagents |
| `claude/settings.json` | `~/.claude/settings.json` | Opus on high effort, fullscreen TUI, dark theme, voice input, status line, and every plugin from the stack turned on |
| `claude/statusline-command.sh` | `~/.claude/statusline-command.sh` | Orange status bar showing user@macbook, folder, git branch, model, context used and the time |
| `claude/skills/no-ai-slop` | `~/.claude/skills/` | Writing skill that edits drafts to sound human without losing your voice |
| `memory/` | `~/.claude/projects/<home>/memory/` | Standing preferences Claude remembers across sessions started in `~`: writing style and how to match themes |
| `install-stack.sh` | | Installs the skill packs, MCP servers and CLIs |
| `SKILLS.md` | | Which skill to use for which job, where packs overlap, and what to know before installing |

## Before you copy this

- **Permissions are wide open.** `settings.json` allows Bash, Edit, Write and web access without asking. That suits how I work. If you want prompts, trim `permissions.allow`.
- **`setup.sh` overwrites your `CLAUDE.md` and `settings.json`.** They're backed up, but merge your own settings back in if you had any.
- **The memory is mine.** It's about my writing style and how I like themes matched. Delete the files in `memory/` that don't fit you.
- **Read `SKILLS.md`** for what the stack runs in the background: claude-mem records sessions, impeccable checks UI edits, and Headroom stays off until you run `headroom init`.
- **ADHD mode is on.** `setup.sh` turns on i-have-adhd for every session, so replies lead with the next action. Delete `~/.claude/.i-have-adhd-always` to turn it off.
