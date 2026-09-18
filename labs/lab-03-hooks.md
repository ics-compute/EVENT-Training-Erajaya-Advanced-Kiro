# Lab 03 — Agent Hooks

**Module 3 · about 30 minutes**

## Goal

Run a command hook, an agent hook, and a blocking hook, and feel the cost
difference.

## Steps

1. Read the four hooks in `.kiro/hooks/`. Note the shape: `version`, a `hooks`
   array, and per hook a `trigger`, an optional `matcher`, and an `action`.
2. **Command hook.** `format-on-save.json` is enabled. Ask Kiro to add a
   badly formatted function to `src/orders/service.py`. The formatter runs
   after the agent saves. No model call, no credits.
3. **Agent hook.** `test-companion.json` ships `"enabled": false` on purpose.
   Turn it on, then ask Kiro to add a `cancel_order` method. The hook fires and
   writes the test. Now watch your credit usage — this one costs on every save.
4. **Blocking hook.** `guard-shell.json` runs `scripts/guard-shell.sh` before
   any shell tool call. Ask Kiro to run `rm -rf /tmp/whatever`. The script exits
   non-zero and the tool never runs.
5. Try the guard from your own terminal to see both paths:

   ```bash
   echo '{"command":"rm -rf /data"}'   | bash scripts/guard-shell.sh; echo "exit=$?"
   echo '{"command":"python -m pytest"}' | bash scripts/guard-shell.sh; echo "exit=$?"
   ```

## Checkpoint

You can name which triggers can block (`PreToolUse`, `PromptSubmit`) and how
they block (the command exits non-zero).

## Watch out

File triggers are IDE only, and they fire on files **the agent** touches — not
on your own manual saves. If your hook seems dead, that is usually why.
