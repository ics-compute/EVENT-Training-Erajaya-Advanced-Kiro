---
inclusion: auto
name: python-style
description: Python conventions for this repo - naming, typing, error handling, and when to raise instead of return None
---

# Python style

Kiro pulls this in when the description matches what you asked for.

- Type hints on every public function. `from __future__ import annotations`
  at the top of new modules.
- Raise a domain error (`OrderNotFound`, `InvalidTransition`) instead of
  returning `None` for a failure. Callers should not have to guess.
- Dataclasses for data, plain classes for behaviour.
- No bare `except:`. Catch the exception you can actually handle.
