#!/usr/bin/env bash
# Lab 04 — bring up the Postgres the MCP server talks to.
#
# Lab 04 asks Kiro to describe the `orders` table. That only works if an
# `orders` table exists somewhere reachable. This script makes one.
#
# Usage:
#   ./scripts/lab04-db-up.sh          # docker, the default
#   ./scripts/lab04-db-up.sh --local  # you already run Postgres on :5432
#
# Then, IN THE SAME SHELL YOU LAUNCH KIRO FROM:
#   export LAB_DATABASE_URI='postgresql://labs:labs@localhost:5432/orders'
#
# That last part is the usual failure. Kiro inherits the environment of the
# process that started it, so exporting the DSN in a different terminal than
# the one you launched Kiro from leaves the MCP server red with no explanation.
set -euo pipefail

cd "$(dirname "$0")/.."

CONTAINER=kiro-labs-pg
SCHEMA=scripts/sql/lab04-orders.sql
DSN='postgresql://labs:labs@localhost:5432/orders'

if [[ ! -f "$SCHEMA" ]]; then
  echo "error: $SCHEMA not found. Run this from the repo root." >&2
  exit 1
fi

if [[ "${1:-}" == "--local" ]]; then
  echo "==> Loading schema into your local Postgres on :5432"
  command -v psql >/dev/null || { echo "error: psql not on PATH" >&2; exit 1; }
  createdb orders 2>/dev/null || echo "    (database 'orders' already exists, reusing)"
  psql -v ON_ERROR_STOP=1 -d orders -f "$SCHEMA"
else
  command -v docker >/dev/null || {
    echo "error: docker not on PATH. Use --local if you run Postgres yourself." >&2
    exit 1
  }

  if docker ps -a --format '{{.Names}}' | grep -qx "$CONTAINER"; then
    echo "==> Removing the previous $CONTAINER so the seed is deterministic"
    docker rm -f "$CONTAINER" >/dev/null
  fi

  echo "==> Starting Postgres 16 as $CONTAINER on :5432"
  docker run -d --name "$CONTAINER" \
    -e POSTGRES_USER=labs \
    -e POSTGRES_PASSWORD=labs \
    -e POSTGRES_DB=orders \
    -p 5432:5432 \
    postgres:16-alpine >/dev/null

  echo -n "==> Waiting for it to accept connections"
  for _ in $(seq 1 30); do
    if docker exec "$CONTAINER" pg_isready -U labs -d orders >/dev/null 2>&1; then
      echo " ok"
      break
    fi
    echo -n "."
    sleep 1
  done

  docker exec "$CONTAINER" pg_isready -U labs -d orders >/dev/null 2>&1 || {
    echo
    echo "error: Postgres did not come up. Check: docker logs $CONTAINER" >&2
    exit 1
  }

  echo "==> Loading $SCHEMA"
  docker exec -i "$CONTAINER" psql -v ON_ERROR_STOP=1 -U labs -d orders < "$SCHEMA" >/dev/null
fi

echo
echo "==> Verifying the seed"
if [[ "${1:-}" == "--local" ]]; then
  psql -d orders -c 'SELECT status, count(*) AS orders FROM orders GROUP BY status ORDER BY status;'
else
  docker exec "$CONTAINER" psql -U labs -d orders \
    -c 'SELECT status, count(*) AS orders FROM orders GROUP BY status ORDER BY status;'
fi

cat <<EOF

Done. 10 orders across 5 customers, including 2 cancelled ones so the points
reversal question in your spec has something real to point at.

Next, in the shell you will launch Kiro from:

    export LAB_DATABASE_URI='$DSN'

Then flip "disabled": true to false on the postgres server in
.kiro/settings/mcp.json and reconnect it from Kiro's MCP panel.

Note: customer_points and points_ledger are NOT in this schema on purpose.
Proposing them from your spec is the lab.

Teardown when you are done:  docker rm -f $CONTAINER
EOF
