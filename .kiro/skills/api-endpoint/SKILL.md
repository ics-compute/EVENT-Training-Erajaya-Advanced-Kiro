---
name: api-endpoint
description: Use when adding or changing an HTTP endpoint for the order service - routes, status codes, request and response shapes, and the tests that go with them.
---

# Adding an endpoint

## Before writing code

1. Find the acceptance criterion in `.kiro/specs/order-tracking/requirements.md`
   that the endpoint serves. If there is none, stop and write it first.
2. Check `.kiro/steering/api-conventions.md` — creating a file under `src/api/`
   pulls those conventions in automatically.

## The shape of the change

1. Route and handler in `src/api/`, thin: parse, call `OrderService`, map the
   result. No business rules in the handler.
2. Map domain errors to status codes:
   `OrderNotFound` -> 404, `InvalidTransition` -> 409, `InvalidOrder` -> 422.
3. Response models never expose the internal dataclass directly.
4. A test per acceptance criterion, named after the criterion.

## Done means

`python -m pytest -q` is green, the new test fails when you revert the handler,
and the endpoint appears in the README route table. See
`references/patterns.md` for the request and response examples.
