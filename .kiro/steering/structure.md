---
inclusion: always
---

# Structure

```
src/orders/       service and domain model (already written, your reference)
src/loyalty/      the Loyalty Points feature you build across the labs
tests/            pytest suite, one file per module
scripts/          shell helpers used by hooks, plus the lab 04 database seed
.kiro/            steering, hooks, agents, skills, specs, mcp settings
powers/           a local power you can import in lab 06
```

Rules that survive every refactor:

- Business logic lives in a `service.py` under its own `src/` package, never in
  a test. `src/orders/service.py` is the shape to copy for `src/loyalty/`.
- Every public method on a service has a test: `OrderService` is covered by
  `tests/test_service.py`, loyalty code belongs in `tests/test_loyalty.py`.
- New modules get a matching test file created in the same change.
- Money is an integer in rupiah minor units, never a float. Points are
  integers too - decide the rounding rule in the spec, not in the code.
