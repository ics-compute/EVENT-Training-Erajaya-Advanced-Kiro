---
name: deploy-checklist
description: Use when the user asks to deploy, release or ship this service to staging or production. Runs the pre-flight checks, the deploy itself, and the health verification afterwards.
---

# Deploy checklist

The description above is the interface. Kiro reads only the name and the
description at startup, and loads this file when a request matches. Write the
trigger into the description, not the implementation.

## Pre-flight

1. The branch must be `main` and the working tree clean: `git status --short`.
2. Tests green: `python -m pytest -q`.
3. Formatting clean: `python -m black --check src/ tests/`.
4. Confirm the target with the user out loud: staging or production. Never
   infer production from silence.

## Deploy

This repo has no real pipeline. Print the command you would run, and stop:

```
echo "deploy order-tracking -> ${TARGET}"
```

Stopping here is the lesson. A skill that prints the plan and asks is more
useful than one that guesses and ships.

## Verify

1. Health check the target and report the status code.
2. Watch the error rate for five minutes.
3. If anything looks wrong, follow `references/rollback.md` — do not improvise.

## Report

One short paragraph: what shipped, where, when, what you checked, what you
would watch overnight.
