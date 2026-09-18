# Lab 05 — Agent Skills

**Module 5 · about 30 minutes**

## Goal

Watch progressive disclosure happen, then write a skill of your own.

## Steps

1. Read `.kiro/skills/deploy-checklist/SKILL.md`. Note what is in the front
   matter: a `name` and a `description` that says *when to use it*, not what is
   inside.
2. In a fresh chat, ask: *"Ship this service to staging."* You never named the
   skill; the description matched, and the file loaded.
3. Follow the flow to the point where it stops and asks you to confirm the
   target. A skill that stops and asks beats one that guesses.
4. Now ask: *"The deploy went bad, what do I do?"* — only now does
   `references/rollback.md` get read. Until this moment it cost you nothing.
5. Read `.kiro/skills/api-endpoint/SKILL.md` and compare the two descriptions.
   One triggers on deploying, one on endpoint work. No overlap, no confusion.

## Build one

Write `.kiro/skills/incident-report/SKILL.md` that turns a rough incident
timeline into the report format your team actually uses. Then test the
description: start a new chat, describe an incident in your own words, and see
whether it fires without you naming it. A skill that never triggers is a skill
with a weak description.

## Checkpoint

You can state the three stages — discovery, activation, execution — and what
Kiro reads at each one.
