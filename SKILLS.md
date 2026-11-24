# Which skill to use when

I installed about twenty skill packs and ended up with five code reviewers, four TDD skills and three planners, and Claude was picking between them on its own. This guide picks one skill for each job, so you know what to ask for. One script installs all of them!

## Install

The [README](README.md) has the full install. If you only want the skills and not my config, run `bash install-stack.sh`. Read it first and delete the lines you don't want. Everything installs at user scope, so it works in every project.

## Name the skill you want

Claude picks a skill by reading its description, and with this many overlaps it will sometimes pick a different pack's version of the one you meant. If you say "use superpowers brainstorming on this", you get exactly that skill. If you say "help me plan this", you get whichever one Claude likes today!

## What to use when

### Plan and build

| You want to | Use | Say something like |
|---|---|---|
| Turn a fuzzy idea into a design | `superpowers:brainstorming` | "brainstorm this feature with me" |
| Have someone poke holes in your plan | `mattpocock-skills:grilling` | "grill me on this plan" |
| Write a spec or PRD | `agent-skills:spec-driven-development` | "write a spec for X" |
| Break a spec into steps | `superpowers:writing-plans` | "write an implementation plan" |
| Carry out the plan | `superpowers:subagent-driven-development` | "execute the plan" |
| Write the tests first | `superpowers:test-driven-development` | "do this TDD" |
| Build a quick prototype | `mattpocock-skills:prototype` | "prototype this so I can feel it out" |
| Work with a full product team (PM, architect, dev, QA) | BMAD, starting with `bmad` | "bmad, where do I start?" |

### Keep the code honest

| You want to | Use | Say something like |
|---|---|---|
| Get the smallest code that works | `ponytail` | "/ponytail" or "be lazy" |
| Get short, blunt replies that use fewer tokens | `caveman` | "caveman mode" |
| Stop Claude from editing more than it needs to | `andrej-karpathy-skills:karpathy-guidelines` | nothing, it turns on when Claude writes code |
| Find the real cause of a bug | `superpowers:systematic-debugging` | "debug this" |
| Review for bugs | the built-in `/code-review` | "/code-review" |
| Review for bloat | `/ponytail-review` | "what can we delete?" |
| Get several reviewers on one change | `bmad-code-review` | "run code review" |
| Make sure it works before Claude says it's done | `superpowers:verification-before-completion` | nothing, it runs before Claude says "done" |
| Check security, speed or accessibility | `agent-skills:security-and-hardening`, `performance-optimization`, `accessibility-engineering` | "harden this", "why is this slow" |

### Understand code

| You want to | Use | Say something like |
|---|---|---|
| Map a repo you don't know | `/understand-anything:understand`, then `understand-chat` | "/understand" |
| Help someone new get started in a repo | `understand-anything:understand-onboard` | "write an onboarding guide" |
| See what a PR actually changes | `understand-anything:understand-diff` | "what does this diff affect?" |
| Build a graph of code, docs or papers you can ask questions about | `graphify` | "/graphify ." |
| Draw an architecture or flow diagram | `archify` | "draw the architecture of this repo" |
| Take apart a binary, app or firmware | `rea:reverse-engineer-anything` | "reverse engineer this app" |

### UI and the web

| You want to | Use | Say something like |
|---|---|---|
| Design, critique or polish any UI | `impeccable` | "/impeccable critique the pricing page", "/impeccable bolder" |
| Build a marketing site that looks good | `taste-skill` | "build a landing page for X" |
| Pick styles, palettes and fonts for an app | `ui-ux-pro-max` | "suggest a palette and type for a fintech dashboard" |
| Drive a real browser and test a site | Playwright MCP | "open localhost:3000 and test signup" |
| Read X, Reddit, Bilibili or YouTube subtitles | `agent-reach` | "read this tweet thread" |

### Writing and video

| You want to | Use | Say something like |
|---|---|---|
| Make a draft sound like you and not a chatbot | `no-ai-slop` | "edit this, keep my voice" |
| Check a draft for AI tells without changing it | `no-ai-slop` | "does this read as AI?" |
| Get an explanation that's plain, literal and hard to misread | `ste` | "explain this in STE", "strict STE" |
| Check a draft against Wikipedia's list of AI writing signs | `humanizer` | "/humanizer" |
| Make a video, promo, explainer or captioned clip | `hyperframes` | "make a 30s launch video for X" |
| Make a slide deck you can click through | `slideshow`, which comes with hyperframes | "turn this into a slideshow" |

### Runs on its own

| What | What it does |
|---|---|
| `i-have-adhd` | Makes replies start with the next thing to do and number the steps. `setup.sh` turns it on for every session. |
| `headroom` | Saves tokens by compressing context through a local proxy. It stays off until you run `headroom init`. |

## Where the packs overlap

The tables above pick one skill for each job. If you'd rather use a different one, these are all the skills that do the same thing.

- Code review is in the built-in `/code-review`, `superpowers:requesting-code-review`, `mattpocock-skills:code-review`, `agent-skills:code-review-and-quality` and `bmad-code-review`.
- TDD is in superpowers, `mattpocock-skills:tdd` and `agent-skills:test-driven-development`.
- Debugging is in superpowers, `mattpocock-skills:diagnosing-bugs` and `agent-skills:debugging-and-error-recovery`.
- Planning is in superpowers, Addy's `planning-and-task-breakdown` and BMAD.
- Codebase maps come from both understand-anything and graphify.
- UI design is in impeccable, taste-skill and ui-ux-pro-max.
- no-ai-slop and humanizer both clean up writing.
- caveman, ponytail and i-have-adhd all make Claude say less.

If Claude keeps picking the wrong skill, turn a pack off with `claude plugin disable <name>`. That fixes it most of the time!

## Read this before you install

- Headroom's hook does nothing until you run `headroom init`, and after that all your Claude Code API traffic goes through its local proxy.
- Agent Reach uses your Chrome login when a site needs one, and its docs suggest a second account for those sites.
- `graphify install` adds a short `# graphify` section to `~/.claude/CLAUDE.md`.
- archify makes diagram pages for complex answers even when you didn't ask, and adding `[archify explainer: on-demand]` to `~/.claude/CLAUDE.md` stops that.
- impeccable runs a quick design check after every file edit and when a session starts.
- no-ai-slop and ste live only in this repo, so `setup.sh` installs them and `install-stack.sh` on its own skips them.
- i-have-adhd stays on in every session while `~/.claude/.i-have-adhd-always` exists, and deleting that file turns it off.
- BMAD v7 is an alpha that changes often, so run `bmad status` to see what you have and `bmad setup` to update it.

## Remove something

```bash
claude plugin uninstall <plugin>@<marketplace>    # plugins
rm -rf ~/.claude/skills/<skill-name>              # archify, bmad-*, graphify, no-ai-slop, ste, hyperframes, caveman
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
