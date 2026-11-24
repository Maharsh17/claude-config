# claude-config

This is my whole Claude Code setup. It has my global instructions, settings, status line and memory, plus about twenty skill packs and a guide that tells you which one to use for what!

## Install

You need [Claude Code](https://claude.com/claude-code), Node 18+, git, [uv](https://docs.astral.sh/uv/) and `jq`. The status line uses `jq`.

```bash
git clone https://github.com/Maharsh17/claude-config.git
cd claude-config
bash setup.sh            # skill stack + config
bash setup.sh --config   # config only, skip the skill stack
```

Restart Claude Code when it finishes. `setup.sh` backs up anything it replaces in `~/.claude` to `~/.claude/backup-<timestamp>/`, so you can run it as many times as you like!

## What's in here

| Path | Goes to | What it is |
|---|---|---|
| `claude/CLAUDE.md` | `~/.claude/CLAUDE.md` | The instructions Claude reads in every session. They cover how I like writing (no em dashes, no slop bullets, few colons, exclamation marks welcome) and how I like engineering done (reproduce bugs first, fix lint and flaky tests when you see them, ask before spawning lots of subagents) |
| `claude/settings.json` | `~/.claude/settings.json` | Opus on high effort, fullscreen TUI, dark theme, voice input, the status line, and every plugin in the stack turned on |
| `claude/statusline-command.sh` | `~/.claude/statusline-command.sh` | An orange status bar with user@macbook, the folder, git branch, model, context used and the time |
| `claude/skills/no-ai-slop` | `~/.claude/skills/` | Edits a draft so it sounds like a person wrote it, and keeps your voice |
| `claude/skills/ste` | `~/.claude/skills/` | Explains or rewrites things in ASD-STE100 Simplified Technical English, at 80% strictness unless you ask for more |
| `memory/` | `~/.claude/projects/<home>/memory/` | Preferences Claude remembers in sessions you start from `~`, about writing style and matching themes |
| `install-stack.sh` | | Installs the skill packs, MCP servers and CLIs |
| `SKILLS.md` | | Which skill to use for which job, where the packs overlap, and what to know before you install |

## Before you copy this

- `settings.json` lets Claude run Bash, edit files and go on the web without asking, so trim `permissions.allow` if you'd rather get prompts.
- `setup.sh` replaces your `CLAUDE.md` and `settings.json`, so merge your own settings back in from the backup if you had any.
- The memory files are about me, so delete the ones that don't fit you.
- impeccable checks your UI after edits, and Headroom does nothing until you run `headroom init`. `SKILLS.md` lists the rest of what runs on its own.
- `setup.sh` turns on i-have-adhd for every session, and you can turn it off by deleting `~/.claude/.i-have-adhd-always`.
