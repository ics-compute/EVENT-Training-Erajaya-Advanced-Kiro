---
inclusion: manual
---

# Incident runbook

Manual steering: nothing loads this until you ask for it by name with
`#incident-runbook`, or pick it from the `/` list.

That is exactly the right mode for a document you need twice a quarter.

1. Confirm the blast radius before touching anything. Which customers, which
   orders, since when.
2. Capture evidence first — logs and the failing request — then mitigate.
3. Mitigate with the smallest reversible action available.
4. Write the timeline while it is fresh. Absolute timestamps, not "20 minutes
   ago".
5. One owner, one channel, one status update every 30 minutes.
