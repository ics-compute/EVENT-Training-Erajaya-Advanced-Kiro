# Lab 09 — Do / Don'ts and Token Efficiency

**Module 9 · about 20 minutes**

## Goal

Make the cost of context visible, then cut it.

## Steps

1. Run `/context` in a fresh session. Note what is loaded before you have asked
   anything — that is your `always` steering.
2. Do a piece of real work: ask for task 6 from `tasks.md`. Run `/context`
   again. Watch it grow.
3. Run `/compact` and look at what survived. Key decisions stay, the noise goes.
4. Now measure a bad habit: paste the whole of `service.py` into chat and ask a
   question about one method. Compare with attaching the file and asking the
   same question.

## The habits worth keeping

- Agree on the requirement before vibe mode, not during.
- More than one step? Use a spec.
- Small commits. It is the cheapest undo there is.
- Review the diff before accepting. You are still the engineer.
- If you cannot explain the code, do not merge it.

## The traps

- Single-shotting a multi-step problem.
- `autoApprove: ["*"]` on a server that can write or destroy.
- An agent hook on a broad matcher, firing all day.
- A long session with no `/compact` — answer quality drops as context fills.

## Checkpoint

You can name two changes you will make to your own setup on Monday.
