---
inclusion: always
---

# Structure

```
src/orders/       service and domain model
tests/            pytest suite, one file per module
scripts/          shell helpers used by hooks
.kiro/            steering, hooks, agents, skills, specs, mcp settings
powers/           a local power you can import in lab 06
labs/             the exercises
```

Rules that survive every refactor:

- Business logic lives in `src/orders/service.py`, never in a test.
- Every public method on `OrderService` has a test in `tests/test_service.py`.
- New modules get a matching test file created in the same change.
