# Lab 01 — Steering & Context Management

**Module 1 · about 20 minutes**

## Goal

See the four inclusion modes behave differently, and feel what `always` costs.

## Steps

1. Open this repo in Kiro. Look at `.kiro/steering/` — six files, four modes.
2. In a fresh chat, ask: *"What is this service and what are the rules of this
   repo?"* Kiro answers from `product.md`, `tech.md` and `structure.md` without
   you attaching anything. Those are `inclusion: always`.
3. Ask: *"What are our API conventions?"* Watch it struggle — `api-conventions.md`
   is `fileMatch` on `src/api/**/*.py`, and that folder does not exist yet.
4. Create `src/api/routes.py` with a single comment line, open it, and ask
   again. The conventions attach themselves.
5. Ask: *"How should I handle errors in Python here?"* — `python-style.md` is
   `inclusion: auto`, so Kiro decides from the description alone.
6. Ask about a production incident. Nothing happens: `incident-runbook.md` is
   `manual`. Now ask again with `#incident-runbook`.

## Checkpoint

You can say, for each of the six files, why it is in the mode it is in.

## Make it yours

Move `python-style.md` to `inclusion: always` and read the file count in
`/context`. Then put it back. Everything in `always` is paid for on every
single request, including the ones that have nothing to do with Python.
