# Lab 04 — Custom Subagents

**Module 4 · about 25 minutes**

## Goal

Use a narrow, read-only agent, and then run specialists in parallel.

## Steps

1. Read `.kiro/agents/code-reviewer.json`. It has `"excludedTools": ["write"]`
   — a reviewer that can edit is not a reviewer.
2. Make a small change to `src/orders/service.py`, then ask the `code-reviewer`
   agent to review the diff. Ask it to fix what it found. It will refuse: it
   has no write tool. That refusal is the design working.
3. Read `.kiro/agents/test-writer.md` — same idea in Markdown, which is easier
   to live with for a long prompt. Note `resources`: it always starts with the
   structure steering and the requirements file loaded.
4. Delegate in parallel: ask the main chat to have `test-writer` cover
   `create_order` and `update_status` as two separate jobs. Each runs with its
   own context and reports back a summary.

## Checkpoint

You can explain why a subagent keeps the main context clean, and when that is
worth the extra orchestration.

## Make it yours

Write a third agent — `docs-writer` — that may read everything and write only
to `README.md`. Tool limits are the cheapest guardrail you will ever configure.
