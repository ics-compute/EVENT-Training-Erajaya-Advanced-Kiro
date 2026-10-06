#!/usr/bin/env python3
"""Lab 04 - build the SQLite database the MCP server talks to.

Lab 04 asks Kiro to describe the `orders` table. That only works if an
`orders` table exists somewhere reachable. This script makes one.

    ./scripts/lab04-db-seed.py

No Docker, no server, no port, no DSN. Just a file at .lab/orders.db that
the SQLite MCP server opens directly. Teardown is `rm -rf .lab`.

Only the Python standard library is used, so if `python3 --version` works
you already have everything you need.
"""

import sqlite3
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
SCHEMA = REPO_ROOT / "scripts" / "sql" / "lab04-orders.sql"
DB_PATH = REPO_ROOT / ".lab" / "orders.db"


def main() -> int:
    if not SCHEMA.exists():
        print(f"error: {SCHEMA} not found. Run this from the repo root.", file=sys.stderr)
        return 1

    DB_PATH.parent.mkdir(parents=True, exist_ok=True)

    # Rebuild every time so the seed is deterministic. Participants re-run
    # this after poking at the data and expect to get the same ten orders.
    if DB_PATH.exists():
        print(f"==> Removing the previous {DB_PATH.name} so the seed is deterministic")
        DB_PATH.unlink()

    print(f"==> Creating {DB_PATH.relative_to(REPO_ROOT)}")
    conn = sqlite3.connect(DB_PATH)
    try:
        conn.executescript(SCHEMA.read_text())
        conn.commit()

        print("==> Verifying the seed")
        rows = conn.execute(
            "SELECT status, count(*) FROM orders GROUP BY status ORDER BY status"
        ).fetchall()
        total = conn.execute("SELECT count(*) FROM orders").fetchone()[0]
        lines = conn.execute("SELECT count(*) FROM order_lines").fetchone()[0]
    finally:
        conn.close()

    print()
    print("    status      orders")
    print("    ----------  ------")
    for status, count in rows:
        print(f"    {status:<10}  {count:>6}")
    print(f"\n    {total} orders, {lines} order lines")

    if total != 10:
        print(f"\nerror: expected 10 orders, got {total}", file=sys.stderr)
        return 1

    print(
        f"""
Done. 10 orders across 5 customers, including 2 cancelled ones so the points
reversal question in your spec has something real to point at.

Next: flip "disabled": true to false on the sqlite server in
.kiro/settings/mcp.json and save. That is the whole setup - the MCP config
already points at {DB_PATH.relative_to(REPO_ROOT)}, so there is no
environment variable to export and no server to start.

Note: customer_points and points_ledger are NOT in this schema on purpose.
Proposing them from your spec is the lab.

Teardown when you are done:  rm -rf .lab
"""
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
