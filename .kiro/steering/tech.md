---
inclusion: always
---

# Tech

- Python 3.11, standard library only for the service itself.
- pytest for tests. Run them with `python -m pytest -q`.
- black for formatting, line length 88 (the default).
- No framework yet. When the API arrives it will be FastAPI; do not add it
  before the spec asks for it.

Dependencies are a decision, not a detail. Propose one before installing it.
