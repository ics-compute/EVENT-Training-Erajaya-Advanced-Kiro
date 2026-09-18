# Tasks — Order Tracking

- [x] 1. Domain model: `Order`, `OrderLine`, `OrderStatus`, `total`
  - Requirements: 1.1, 2.1
- [x] 2. `OrderService.create_order` with validation
  - Requirements: 1.1, 1.2, 1.3, 1.4, 1.5
- [x] 3. `OrderService.get_order` and `OrderNotFound`
  - Requirements: 2.1, 2.2
- [x] 4. Status machine and `update_status`
  - Requirements: 3.1, 3.2, 3.3, 3.4
- [x] 5. `list_for_customer`, newest first, case-insensitive
  - Requirements: 4.1, 4.2, 4.3
- [ ] 6. HTTP layer under `src/api/` following `api-conventions.md`
  - Requirements: 1.1, 2.1, 3.1, 4.1
  - This is the task lab 07 hands to Kiro.
- [ ] 7. Persistence behind the existing service interface
  - Blocked on design open question 2.

Each task names the requirements it satisfies. That mapping is what makes the
spec traceable — and what lets a reviewer ask "which requirement asked for
this?" about any line of code.
