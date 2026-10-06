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
git clone https://github.com/ics-compute/EVENT-Training-Erajaya-Advanced-Kiro.git kiro-advanced-labs
cd kiro-advanced-labs
python -m venv .venv && source .venv/bin/activate
pip install pytest black
python -m pytest -q          # 9 passing tests
```

Then open the folder in Kiro IDE and follow the lab instructions at
<https://kiro-eventerajaya.icscompute.com/>. This repo holds the configuration
you work on; the step-by-step exercises live on the site.

## The labs

The ten exercises are published at <https://kiro-eventerajaya.icscompute.com/>,
numbered in running order:

1. Requirement to Functional Spec
2. Kiro IDE and CLI
3. Steering
4. MCP Integration
5. Skills
6. Powers (import `powers/erajaya-platform/`)
7. Hooks
8. Subagents
9. Governance (discussion-led)
10. Tokens and context

Roughly 6.5 hours end to end, split across five sessions.

### One feature, ten labs

The labs are not ten unrelated exercises. They build **one** feature end to
end: **Loyalty Points for Erajaya customers** — earn points on every purchase,
see the balance, redeem at checkout. Each lab's output is the next lab's input:

| Lab | You build | Hands off |
|---|---|---|
| 01 | `.kiro/specs/loyalty-points/` (requirements, design, tasks) | the spec everything else cites |
| 02 | open that spec from both IDE and CLI | proof both surfaces share `.kiro/` |
| 03 | steering that auto-attaches to the loyalty endpoint | conventions ready for coding |
| 04 | a proposed `customer_points` and `points_ledger` schema | storage model for the skill |
| 05 | a `redeem-points` skill with `references/` | the operational playbook |
| 06 | a `points-balance-check` power skill | cross-repo platform knowledge |
| 07 | `src/loyalty/service.py` plus hook-generated tests | the actual code |
| 08 | a review pass and parallel edge-case tests | reviewed, covered code |
| 09 | a loyalty-points PR checklist | the merge decision |
| 10 | `/context` and `/compact` on the day's chat | context discipline |

So **do not pre-write the loyalty code.** `src/loyalty/` ships as an empty
package on purpose — filling it is lab 07. `src/orders/` is the finished
reference to copy the shape from.

### Lab 04 needs a database

Lab 04 asks Kiro to describe a real `orders` table over MCP, so one has to
exist:

```bash
./scripts/lab04-db-seed.py
```

That writes a SQLite file to `.lab/orders.db` using nothing but the Python
standard library. No Docker, no server, no port, no connection string, and
nothing to export — `mcp.json` already points the SQLite MCP server at that
path. Teardown is `rm -rf .lab`.

Run it from the repo root. The MCP server resolves `.lab/orders.db` relative
to the directory Kiro was started in, and it **creates an empty database when
the path is wrong** rather than failing loudly — so if `list_tables` comes
back with nothing, you are looking at a different file, not a broken server.

The seed deliberately has no `customer_points` table; proposing one is the lab.

## What is in here

```
.kiro/
  steering/    six files: always, fileMatch, auto, manual - one of each to compare
  settings/    mcp.json - three servers, two of them shipped disabled
  hooks/       command, agent, blocking and session hooks
  agents/      code-reviewer (JSON, read-only) and test-writer (Markdown)
  skills/      deploy-checklist and api-endpoint, both with references/
  specs/       order-tracking: requirements (EARS), design, tasks
powers/        erajaya-platform: plugin.json + mcp.json + skills, import it in lab 06
scripts/       guard-shell.sh (the blocking hook) and lab04-db-seed.py + sql/ seed
src/orders/    the sample service, finished - your reference for shape
src/loyalty/   empty on purpose - you fill this in lab 07
tests/         pytest suite
```

## Ground rules

- **No credentials, ever.** Nothing in `.kiro/` holds a secret, and the lab 04
  database is a throwaway local file for exactly that reason. A committed key
  is a leaked key, including in a lab.
- **The guard hook is a teaching aid,** not a security control. It blocks a
  list of obvious patterns and nothing more.
- Servers that can write or destroy are shipped `"disabled": true`. Turn them
  on deliberately, one at a time.

## Verified against

kiro.dev documentation as of September 2026: steering inclusion modes, the hook
trigger and action reference, the Agent Plugins power format, and the spec
workflow. Where Kiro's behaviour and this repo disagree, Kiro is right — open an
issue and we will fix the lab.
