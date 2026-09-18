---
inclusion: always
---

# Product

Order Tracking is the sample service used in the Advanced Kiro labs. It is
deliberately small: a handful of Python modules, one spec, one test suite.

- Customers create an order and follow its status.
- Support staff move an order between statuses and look up a customer history.
- There is no database yet. Orders live in memory, behind a repository class,
  so the storage decision stays open.

Keep this file short. It is loaded into every single request.
