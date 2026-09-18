# Lab 08 — Team Collaboration & Enterprise Governance

**Module 8 · about 20 minutes, discussion-led**

## Goal

See that the real guardrails are in the repo, and know what the console adds
on top.

## In the repo

Walk through what this repo enforces for every person who clones it:

| File | What it governs |
|---|---|
| `.kiro/settings/mcp.json` | Which servers exist, what is auto-approved, which tools are hidden |
| `.kiro/hooks/guard-shell.json` | Shell commands that never run |
| `.kiro/agents/code-reviewer.json` | An agent that cannot write, by construction |
| `.kiro/steering/*` | The conventions, loaded whether anyone remembers them or not |

None of that is a policy document. It is configuration, reviewed like code.

## In the console

Discuss with the group, against your own account:

1. Who administers Kiro today, and is it an IAM identity or a shared login?
2. Are seats assigned to groups from your IdP, or to individuals by hand?
3. Is overage on? It is off by default — turning it on means a bill that can
   grow.
4. What happens to someone's Kiro access on their last day?

## Checkpoint

You can name one guardrail that belongs in the repo and one that only the
console can enforce, and explain why each sits where it does.
