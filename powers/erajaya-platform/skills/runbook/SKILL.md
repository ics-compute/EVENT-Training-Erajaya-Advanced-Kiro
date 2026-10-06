---
name: runbook
description: Use when the order service or loyalty points are misbehaving in an environment - slow, erroring, stuck orders, or a customer points balance that looks wrong - and you need the standard triage path before escalating.
---

# Order and loyalty service triage

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
| Points balance looks wrong | Ledger and balance have drifted | Read `points_ledger` for that customer and re-add it |
| Points credited twice | Earn ran twice for one order | Duplicate `order_id` in `points_ledger` |
| Points missing after an order | Order not in a crediting state yet | `orders.status` for that order id |
| Redemption left a negative balance | Redeem did not check the balance first | Ledger entries ordered by time, find the crossing |

## Triage path for a wrong points balance

The ledger is the source of truth; the balance is a cache of it. Always
reconcile in that direction.

1. Sum the ledger: every entry for that `customer_id`, earned minus redeemed.
2. Compare with the stored balance in `customer_points`. A difference is
   drift, and the ledger wins.
3. If the ledger itself is wrong, find which entry should not be there -
   usually a duplicate `order_id`, or a redemption with no matching checkout.
4. Never hand-edit the balance to make a customer happy. Write a correcting
   ledger entry so the next reconciliation agrees with you.

## Escalation

Escalate when the mitigation is not obvious within 15 minutes, or when the
blast radius grows while you work. Escalating early is cheap; a silent hour is
not. For points disputes, escalate before any write that is not a correcting
ledger entry.
