# My Claude Code skill stack, and which skill to use when

I installed about twenty skill packs and ended up with five code reviewers, four TDD skills and three planners, with Claude choosing between them on its own. This is the condensed version. One script installs the whole stack, and the table below gives one pick per job so you know what to ask for.

## Install

See the [README](README.md). To install only the skills, without my config, run `bash install-stack.sh`. Read it first and delete the lines you don't want. Everything installs at user scope, so it works in every project.

## The one rule

Name the skill you want. Claude picks skills by their descriptions, and with this many overlaps it will sometimes grab a different pack's version. "Use superpowers brainstorming on this" gets you that exact skill. A bare "help me plan this" gets you whichever one Claude likes today.

## What to use when

### Plan and build

| You want to | Use | Say something like |
|---|---|---|
| Turn a fuzzy idea into a design | `superpowers:brainstorming` | "brainstorm this feature with me" |
| Have your plan attacked | `mattpocock-skills:grilling` | "grill me on this plan" |
| Write a spec or PRD | `agent-skills:spec-driven-development` | "write a spec for X" |
| Break a spec into steps | `superpowers:writing-plans` | "write an implementation plan" |
| Carry out the plan | `superpowers:subagent-driven-development` | "execute the plan" |
| Write tests first | `superpowers:test-driven-development` | "do this TDD" |
| Throw together a prototype | `mattpocock-skills:prototype` | "prototype this so I can feel it out" |
| Run a full product team (PM, architect, dev, QA) | BMAD, start with `bmad` | "bmad, where do I start?" |

### Keep code honest

| You want to | Use | Say something like |
|---|---|---|
| The smallest code that works | `ponytail` | "/ponytail" or "be lazy" |
| Short, blunt replies that save tokens | `caveman` | "caveman mode" |
| Fewer overreaching edits | `andrej-karpathy-skills:karpathy-guidelines` | it applies itself when writing code |
| Find a bug's real cause | `superpowers:systematic-debugging` | "debug this" |
| Review for bugs | built-in `/code-review` | "/code-review" |
| Review for bloat | `/ponytail-review` | "what can we delete?" |
| Review with several reviewers at once | `bmad-code-review` | "run code review" |
| Check it actually works before calling it done | `superpowers:verification-before-completion` | runs before Claude claims "done" |
| Security, performance, accessibility passes | `agent-skills:security-and-hardening`, `performance-optimization`, `accessibility-engineering` | "harden this", "why is this slow" |

### Understand code

| You want to | Use | Say something like |
|---|---|---|
| Map an unfamiliar repo | `/understand-anything:understand`, then `understand-chat` | "/understand" |
| Onboard someone to a repo | `understand-anything:understand-onboard` | "write an onboarding guide" |
| Know what a PR really changes | `understand-anything:understand-diff` | "what does this diff affect?" |
| A queryable graph of code, docs, papers | `graphify` | "/graphify ." |
| An architecture or flow diagram | `archify` | "draw the architecture of this repo" |
| Take apart a binary, app or firmware | `rea:reverse-engineer-anything` | "reverse engineer this app" |

### UI and the web

| You want to | Use | Say something like |
|---|---|---|
| Design, critique or polish any UI | `impeccable` | "/impeccable critique the pricing page", "/impeccable bolder" |
| A good-looking marketing site | `taste-skill` | "build a landing page for X" |
| Pick styles, palettes, fonts for app UI | `ui-ux-pro-max` | "suggest a palette and type for a fintech dashboard" |
| Drive a real browser and test a site | Playwright MCP | "open localhost:3000 and test signup" |
| Read X, Reddit, YouTube subtitles, Bilibili | `agent-reach` | "read this tweet thread" |

### Writing and video

| You want to | Use | Say something like |
|---|---|---|
| Make a draft sound like you, not a chatbot | `no-ai-slop` | "edit this, keep my voice" |
| Check a draft for AI tells without rewriting | `no-ai-slop` | "does this read as AI?" |
| A second pass against Wikipedia's AI-writing list | `humanizer` | "/humanizer" |
| Make a video, promo, explainer or captioned clip | `hyperframes` | "make a 30s launch video for X" |
| A slide deck you can click through | `slideshow` (from hyperframes) | "turn this into a slideshow" |

### Runs in the background

| What | What it does |
|---|---|
| `i-have-adhd` | Replies lead with the next action and number the steps. `setup.sh` turns it on for every session. |
| `headroom` | Compresses context to save tokens through a local proxy. Off until you run `headroom init`. |

## Where the packs overlap

These all do the same jobs. The table above picks one, but here's the full list if you'd rather use another.

- Code review comes from built-in `/code-review`, `superpowers:requesting-code-review`, `mattpocock-skills:code-review`, `agent-skills:code-review-and-quality`, `bmad-code-review`
- TDD comes from superpowers, `mattpocock-skills:tdd`, `agent-skills:test-driven-development`
- Debugging comes from superpowers, `mattpocock-skills:diagnosing-bugs`, `agent-skills:debugging-and-error-recovery`
- Codebase maps come from understand-anything and graphify
- UI design comes from impeccable, taste-skill and ui-ux-pro-max
- Writing cleanup comes from no-ai-slop and humanizer
- Caveman, ponytail and i-have-adhd all push Claude to say less
- Planning comes from superpowers, Addy's `planning-and-task-breakdown` and BMAD

If skill picks start going wrong, disable a pack with `claude plugin disable <name>`.

## Read before you install

- Headroom's hook only does something after `headroom init`. Once you run that, all Claude Code API traffic goes through its local proxy.
- Agent Reach borrows a site's login from your Chrome when a site needs one. Its own docs suggest using a secondary account for those.
- `graphify install` adds a short `# graphify` section to `~/.claude/CLAUDE.md`.
- archify makes diagram pages unasked for complex answers. Add `[archify explainer: on-demand]` to `~/.claude/CLAUDE.md` to get pages only when you ask.
- impeccable runs a design check after every file edit and at session start. It's fast, but it's there.
- no-ai-slop has no upstream repo. It lives in this repo and `setup.sh` installs it, so `install-stack.sh` alone skips it.
- i-have-adhd is on for every session while `~/.claude/.i-have-adhd-always` exists. Delete that file to turn it off.
- BMAD v7 is an alpha and changes often. `bmad status` shows what you have and `bmad setup` updates it.

## Remove something

```bash
claude plugin uninstall <plugin>@<marketplace>    # plugins
rm -rf ~/.claude/skills/<skill-name>              # archify, bmad-*, graphify, no-ai-slop, hyperframes, caveman
uv tool uninstall graphifyy agent-reach headroom-ai
claude mcp remove playwright --scope user
```

## Sources

[superpowers](https://github.com/obra/superpowers) ·
[mattpocock/skills](https://github.com/mattpocock/skills) ·
[addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) ·
[karpathy skills](https://github.com/multica-ai/andrej-karpathy-skills) ·
[ponytail](https://github.com/DietrichGebert/ponytail) ·
[caveman](https://github.com/juliusbrussee/caveman) ·
[BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD) ·
[Understand-Anything](https://github.com/Egonex-AI/Understand-Anything) ·
[graphify](https://github.com/Graphify-Labs/graphify) ·
[archify](https://github.com/tt-a1i/archify) ·
[rea](https://github.com/morluto/rea) ·
[impeccable](https://github.com/pbakaus/impeccable) ·
[taste-skill](https://github.com/Leonxlnx/taste-skill) ·
[ui-ux-pro-max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) ·
[humanizer](https://github.com/blader/humanizer) ·
[hyperframes](https://github.com/heygen-com/hyperframes) ·
[Playwright MCP](https://github.com/microsoft/playwright-mcp) ·
[Agent Reach](https://github.com/Panniantong/Agent-Reach) ·
[i-have-adhd](https://github.com/ayghri/i-have-adhd) ·
[headroom](https://github.com/headroomlabs-ai/headroom)
