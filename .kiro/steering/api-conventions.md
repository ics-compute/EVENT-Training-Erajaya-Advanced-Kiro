---
inclusion: fileMatch
fileMatchPattern: "src/api/**/*.py"
---

# API conventions

Loaded only when a file under `src/api/` is in context. There is no such
folder yet — that is the point of the lab: create one and watch this file
attach itself.

- Routes are plural nouns: `/orders`, `/orders/{order_id}`.
- Status codes: 201 on create, 404 when the order does not exist, 409 when a
  status transition is not allowed.
- Errors return `{"error": {"code": "...", "message": "..."}}`.
- Never return the internal repository object. Map it to a response model.
