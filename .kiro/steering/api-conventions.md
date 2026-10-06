---
inclusion: fileMatch
fileMatchPattern: ["src/api/**/*.py", "src/loyalty/**/*.py"]
---

# API conventions

Loaded only when an HTTP-facing file is in context: anything under `src/api/`
or `src/loyalty/`. Neither the `src/api/` folder nor the loyalty endpoint
exists yet — that is the point of the lab: create one and watch this file
attach itself.

- Routes are plural nouns: `/orders`, `/orders/{order_id}`,
  `/customers/{customer_id}/points`.
- Status codes: 201 on create, 404 when the order does not exist, 409 when a
  status transition is not allowed.
- Errors return `{"error": {"code": "...", "message": "..."}}`.
- Never return the internal repository object. Map it to a response model.
