# Requirements — Order Tracking

Status: approved. This is the file a Kiro spec session writes, kept here so
lab 07 has something to compare against. Acceptance criteria are in EARS
notation: one trigger, one behaviour, one sentence.

## Requirement 1 — Place an order

**User story:** As a customer, I want to place an order with my email and at
least one item, so that I can track it later.

Acceptance criteria:

1. WHEN a customer submits an order with a valid email and at least one line
   THE SYSTEM SHALL create the order with status `placed` and return its id.
2. WHEN a customer submits an order with an invalid email address
   THE SYSTEM SHALL reject the order and report which field was wrong.
3. WHEN a customer submits an order with no lines
   THE SYSTEM SHALL reject the order.
4. WHEN a customer submits a line with a quantity below 1
   THE SYSTEM SHALL reject the order.
5. WHEN an order is created with an email in mixed case
   THE SYSTEM SHALL store the email in lowercase.

## Requirement 2 — Follow an order

**User story:** As a customer, I want to look up an order by its id, so that I
can see where it is.

Acceptance criteria:

1. WHEN a customer requests an order id that exists
   THE SYSTEM SHALL return the order with its current status and total.
2. WHEN a customer requests an order id that does not exist
   THE SYSTEM SHALL report that the order was not found.

## Requirement 3 — Move an order through its lifecycle

**User story:** As support staff, I want to move an order to its next status,
so that the customer sees accurate progress.

Acceptance criteria:

1. WHEN support moves an order along the allowed path
   (placed -> packed -> shipped -> delivered)
   THE SYSTEM SHALL apply the new status and return the updated order.
2. WHEN support attempts a transition that skips a step
   THE SYSTEM SHALL reject it and state the transition that was refused.
3. WHEN support attempts to cancel an order that is already delivered
   THE SYSTEM SHALL reject it.
4. WHILE an order is in `placed` or `packed`
   THE SYSTEM SHALL allow it to be cancelled.

## Requirement 4 — Customer history

**User story:** As support staff, I want every order for one customer, so that
I can answer "where is my stuff" in one look.

Acceptance criteria:

1. WHEN support requests the history for a customer email
   THE SYSTEM SHALL return that customer's orders, newest first.
2. WHEN support requests the history using a different letter case
   THE SYSTEM SHALL return the same result as the lowercase form.
3. WHEN a customer has no orders
   THE SYSTEM SHALL return an empty list rather than an error.

## Out of scope

Payment, stock reservation, delivery partner integration, and persistence.
Say so explicitly — an FS is judged as much by what it excludes.
