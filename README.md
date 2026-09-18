# Advanced Kiro — Hands-on Labs

Practice repo for the **Advanced Kiro** supplement modules (Erajaya training,
ICS Managed Service). The deck teaches the concept; this repo is where you run
it.

Everything here is real configuration, not screenshots: six steering files in
four inclusion modes, four hooks, two custom agents, two skills, a spec with
EARS acceptance criteria, and an installable power. The sample service is small
on purpose — the subject of the labs is Kiro, not the domain.

## Getting started

```bash
git clone <this repo>
cd kiro-advanced-labs
python -m venv .venv && source .venv/bin/activate
pip install pytest black
python -m pytest -q          # 9 passing tests
```

Then open the folder in Kiro IDE and follow the lab instructions at
<https://event.dimasutomo.com/>. This repo holds the configuration you work on;
the step-by-step exercises live on the site.

## The labs

The nine exercises are published at <https://event.dimasutomo.com/> — steering,
MCP, hooks, subagents, skills, powers, requirement-to-FS, governance, and
tokens, in that order. Roughly 3.5 hours end to end.

## What is in here

```
.kiro/
  steering/    six files: always, fileMatch, auto, manual - one of each to compare
  settings/    mcp.json - three servers, secrets by ${ENV_VAR} only
  hooks/       command, agent, blocking and session hooks
  agents/      code-reviewer (JSON, read-only) and test-writer (Markdown)
  skills/      deploy-checklist and api-endpoint, both with references/
  specs/       order-tracking: requirements (EARS), design, tasks
powers/        erajaya-platform: plugin.json + mcp.json + skills, import it in lab 06
scripts/       guard-shell.sh, the blocking hook's script
src/orders/    the sample service
tests/         pytest suite
```

## Ground rules

- **No credentials, ever.** `mcp.json` references `${LAB_DATABASE_URI}`; it
  never holds a value. A committed key is a leaked key, including in a lab.
- **The guard hook is a teaching aid,** not a security control. It blocks a
  list of obvious patterns and nothing more.
- Servers that can write or destroy are shipped `"disabled": true`. Turn them
  on deliberately, one at a time.

## Verified against

kiro.dev documentation as of September 2026: steering inclusion modes, the hook
trigger and action reference, the Agent Plugins power format, and the spec
workflow. Where Kiro's behaviour and this repo disagree, Kiro is right — open an
issue and we will fix the lab.
