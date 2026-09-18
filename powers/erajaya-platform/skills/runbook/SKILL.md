---
name: runbook
description: Use when the order service is misbehaving in an environment - slow, erroring, or stuck orders - and you need the standard triage path before escalating.
---

# Order service triage

## First five minutes

1. Which environment, since when, how many customers. Write it down before you
   touch anything.
2. Health endpoint and error rate. Is it failing, or slow?
3. Last deploy: `git log --oneline -5`. A deploy inside the window is the
   first suspect, not the last.

## Common shapes

| Symptom | Likely cause | First check |
|---|---|---|
| Orders stuck in `packed` | Status worker not consuming | Worker process and its queue depth |
| `InvalidTransition` spike | A client retrying a completed step | Which client, which order ids |
| Slow history lookups | Full scan over the order store | Customer with the most orders |

## Escalation

Escalate when the mitigation is not obvious within 15 minutes, or when the
blast radius grows while you work. Escalating early is cheap; a silent hour is
not.
