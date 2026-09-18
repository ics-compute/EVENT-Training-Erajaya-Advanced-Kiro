# Design — Order Tracking

## Approach

One service class over an in-memory dict. Storage is behind `OrderService` so
the persistence decision can be made later without touching callers.

## Components

| Component | File | Responsibility |
|---|---|---|
| `Order`, `OrderLine`, `OrderStatus` | `src/orders/models.py` | Data only. No behaviour beyond `total`. |
| `OrderService` | `src/orders/service.py` | Validation, the status machine, lookup. |
| Domain errors | `src/orders/service.py` | `OrderNotFound`, `InvalidTransition`, `InvalidOrder`. |

## Status machine

```
placed ──▶ packed ──▶ shipped ──▶ delivered
  │          │
  └──────────┴──▶ cancelled
```

`ALLOWED` in `service.py` is the single source of truth for this diagram. When
the diagram and the dict disagree, the dict wins and the diagram is a bug.

## Decisions

- **Money in minor units (int).** Floats and currency do not mix.
- **Errors raise, they do not return None.** The caller cannot silently ignore
  a failure it never saw.
- **Email lowercased on write, not on read.** One normalisation point.

## Open questions

1. Does cancelling a shipped order need a return flow? Currently refused.
2. Should history be paginated before it reaches a real database? Probably.
