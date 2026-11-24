# claude-config

My Claude Code setup in one repo, with global instructions, settings, status line, memory, and a stack of about twenty skill packs with a guide to which one to use when.

## Install

You need [Claude Code](https://claude.com/claude-code), Node 18+, git, [uv](https://docs.astral.sh/uv/) and `jq` (for the status line).

```bash
git clone https://github.com/Maharsh17/claude-config.git
cd claude-config
bash setup.sh            # skill stack + config
bash setup.sh --config   # config only, skip the skill stack
```

Restart Claude Code afterwards. Anything `setup.sh` replaces in `~/.claude` is backed up to `~/.claude/backup-<timestamp>/` first. It's safe to run again.

## What's in here

| Path | Goes to | What it is |
|---|---|---|
| `claude/CLAUDE.md` | `~/.claude/CLAUDE.md` | Global instructions for every session. No em dashes, write like a human, reproduce bugs end to end before fixing, fix lint and flaky tests on sight, ask before spawning a swarm of subagents |
| `claude/settings.json` | `~/.claude/settings.json` | Opus on high effort, fullscreen TUI, dark theme, voice input, status line, and every plugin from the stack turned on |
| `claude/statusline-command.sh` | `~/.claude/statusline-command.sh` | Orange status bar showing user@macbook, folder, git branch, model, context used and the time |
| `claude/skills/no-ai-slop` | `~/.claude/skills/` | Writing skill that edits drafts to sound human without losing your voice |
| `claude/skills/ste` | `~/.claude/skills/` | Writing skill that explains or rewrites in ASD-STE100 Simplified Technical English, 80% strict by default |
| `memory/` | `~/.claude/projects/<home>/memory/` | Standing preferences Claude remembers across sessions started in `~`, covering writing style and how to match themes |
| `install-stack.sh` | | Installs the skill packs, MCP servers and CLIs |
| `SKILLS.md` | | Which skill to use for which job, where packs overlap, and what to know before installing |

## Before you copy this

- `settings.json` lets Claude run Bash, edit files and use the web without asking, so trim `permissions.allow` if you want prompts.
- `setup.sh` overwrites your `CLAUDE.md` and `settings.json` after backing them up, so merge your own settings back in if you had any.
- The files in `memory/` describe my writing style and how I like themes matched, so delete the ones that don't fit you.
- impeccable runs a design check after UI edits, and Headroom does nothing until you run `headroom init`. `SKILLS.md` covers the rest.
- `setup.sh` turns on i-have-adhd for every session, and deleting `~/.claude/.i-have-adhd-always` turns it off.
