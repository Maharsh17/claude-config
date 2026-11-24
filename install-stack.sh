#!/usr/bin/env bash
# Claude Code skill stack installer.
# Installs everything at user scope so it works in every project.
# Safe to re-run. Delete any line you don't want before running.
# Needs: claude (Claude Code), node 18+ (npx), git, uv.
set -u

for bin in claude npx git uv; do
  command -v "$bin" >/dev/null || { echo "missing: $bin (install it first)"; exit 1; }
done

failed=()
plugin() { # usage: plugin <github owner/repo> <plugin@marketplace>
  claude plugin marketplace add "$1" >/dev/null 2>&1 || true # already added is fine
  claude plugin install "$2" --scope user || failed+=("$2")
}
skills() { # usage: skills <npx skills source> [extra args]
  npx -y skills@latest add "$@" --agent claude-code --global --copy --yes || failed+=("$1")
}

echo "== Workflow (plan, build, test, debug, review)"
plugin anthropics/claude-plugins-official superpowers@claude-plugins-official
plugin mattpocock/skills                  mattpocock-skills@mattpocock
plugin addyosmani/agent-skills            agent-skills@addy-agent-skills
plugin multica-ai/andrej-karpathy-skills  andrej-karpathy-skills@karpathy-skills
plugin DietrichGebert/ponytail            ponytail@ponytail
skills juliusbrussee/caveman --skill caveman
skills bmad-code-org/BMAD-METHOD/skills/core-tools --skill '*'
skills bmad-code-org/BMAD-METHOD/skills/method     --skill '*'

echo "== Understanding code"
plugin Egonex-AI/Understand-Anything understand-anything@understand-anything
plugin morluto/rea                   rea@rea
skills tt-a1i/archify --skill archify
uv tool install graphifyy && graphify install || failed+=(graphify) # note: adds a short section to ~/.claude/CLAUDE.md

echo "== UI and design"
plugin pbakaus/impeccable                   impeccable@impeccable # adds a design check after every Edit/Write
plugin Leonxlnx/taste-skill                 taste-skill@taste-skill
plugin nextlevelbuilder/ui-ux-pro-max-skill ui-ux-pro-max@ui-ux-pro-max-skill

echo "== Writing"
plugin blader/humanizer humanizer@humanizer

echo "== Video and slides"
skills heygen-com/hyperframes --skill '*' # HTML-to-video: promos, explainers, captions, slideshows

echo "== Browser and web"
claude mcp add playwright --scope user -- npx -y @playwright/mcp@latest 2>/dev/null || true # already added is fine
# Agent Reach: install from GitHub only. The PyPI package with the same name is a different project.
uv tool install https://github.com/Panniantong/Agent-Reach/releases/latest/download/agent-reach.zip \
  && agent-reach setup >/dev/null || failed+=(agent-reach)

echo "== Session quality of life"
plugin ayghri/i-have-adhd     i-have-adhd@i-have-adhd
plugin thedotmack/claude-mem  claude-mem@thedotmack
npx -y claude-mem telemetry disable || true
# Headroom: plugin + CLI only. Its hook does nothing until you run `headroom init`,
# which routes all Claude Code API traffic through a local proxy.
plugin headroomlabs-ai/headroom headroom@headroom-marketplace
uv tool install headroom-ai || failed+=(headroom-ai)

echo
if [ ${#failed[@]} -eq 0 ]; then
  echo "Done. Restart Claude Code to load everything."
else
  echo "Done with failures: ${failed[*]}"
  echo "Re-run the script, or install those by hand."
  exit 1
fi
