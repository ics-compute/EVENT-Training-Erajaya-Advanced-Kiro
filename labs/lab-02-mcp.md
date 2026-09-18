# Lab 02 — MCP Integration

**Module 2 · about 20 minutes**

## Goal

Start a server from a committed config, and understand `autoApprove`.

## Steps

1. Read `.kiro/settings/mcp.json`. Three servers; two are `"disabled": true`.
2. The AWS Knowledge server needs no credentials — reconnect it from the MCP
   panel and ask: *"What are the current limits on an Aurora Serverless v2
   cluster?"* The answer comes from live docs, not the model's memory.
3. Look at `autoApprove` on that server: only the two read tools. Read-only is
   the only kind of tool that belongs there.
4. Enable the `postgres` server by flipping `disabled` to `false`. It needs
   `LAB_DATABASE_URI` in your environment — note that the config holds
   `${LAB_DATABASE_URI}`, never the value. A committed secret is a leaked
   secret.
5. Note `disabledTools` on that server: `execute_sql` is hidden even though the
   server offers it.

## Checkpoint

You can explain the difference between workspace and user `mcp.json`, and why
this one is committed to the repo.

## Make it yours

Add the Playwright server (already stubbed, disabled) and ask Kiro to open the
Kiro docs and summarise the hooks page. Watch the approval prompt appear —
that server writes and clicks, so it does not get `autoApprove`.
