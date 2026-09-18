# Lab 06 — Kiro Powers

**Module 6 · about 20 minutes**

## Goal

Install a power from a folder and see how it differs from a loose skill.

## Steps

1. Read `powers/erajaya-platform/`. Three parts: `plugin.json` (the manifest),
   `mcp.json` (tools), and `skills/runbook/` (the know-how). One package.
2. In Kiro: Powers panel > Add Custom Power > import from a folder > point it
   at `powers/erajaya-platform`.
3. Look at `keywords` in the manifest: `runbook`, `deploy`, `order-service`,
   `platform`, `oncall`. Those are the activation surface.
4. Ask: *"Orders are stuck in packed on staging, where do I start?"* You said
   none of the keywords exactly, but the power activates and the runbook skill
   answers.
5. Compare with lab 05: the skill needed the repo. The power travels — another
   team installs it and gets the tools and the know-how together.

## Checkpoint

You can answer the question on the deck: one procedure = skill, data or tool
access = MCP, a whole capability the team installs once = power.

## Make it yours

Add a second skill to the power — `capacity-check` — and reinstall. Powers are
how internal platform knowledge stops living in one person's head.

Requires Kiro IDE 1.0.437 or later, or CLI v3 or later.
