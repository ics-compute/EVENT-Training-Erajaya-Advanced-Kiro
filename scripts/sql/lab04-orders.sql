-- Lab 04 seed schema: the "existing" Erajaya order tables.
--
-- This is the schema Kiro inspects through the Postgres MCP server when you
-- ask it to describe `orders` and propose a `customer_points` table.
--
-- Deliberately does NOT contain customer_points or points_ledger. Proposing
-- those is the lab. If they already existed, Kiro would just read them back
-- to you and you would learn nothing.

DROP TABLE IF EXISTS order_lines;
DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id        text PRIMARY KEY,
    customer_id     text        NOT NULL,
    customer_email  text        NOT NULL,
    status          text        NOT NULL
        CHECK (status IN ('placed', 'packed', 'shipped', 'delivered', 'cancelled')),
    -- Minor units (rupiah), never a float. Mirrors src/orders/models.py.
    total_idr       bigint      NOT NULL CHECK (total_idr >= 0),
    created_at      timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX orders_customer_id_idx ON orders (customer_id);
CREATE INDEX orders_status_idx      ON orders (status);

CREATE TABLE order_lines (
    id              bigserial PRIMARY KEY,
    order_id        text    NOT NULL REFERENCES orders (order_id) ON DELETE CASCADE,
    sku             text    NOT NULL,
    quantity        integer NOT NULL CHECK (quantity > 0),
    unit_price_idr  bigint  NOT NULL CHECK (unit_price_idr >= 0)
);

CREATE INDEX order_lines_order_id_idx ON order_lines (order_id);

COMMENT ON TABLE  orders               IS 'Customer orders. One row per checkout.';
COMMENT ON COLUMN orders.customer_id   IS 'Stable customer key. Join on this for loyalty.';
COMMENT ON COLUMN orders.total_idr     IS 'Order total in rupiah, minor units. Earn rate applies to this.';
COMMENT ON COLUMN orders.status        IS 'Lifecycle state. Points reversal cares about cancelled.';

-- A spread of statuses and totals, so the earn-rate and reversal questions in
-- the loyalty-points spec have real rows to reason about.
INSERT INTO orders (order_id, customer_id, customer_email, status, total_idr, created_at) VALUES
    ('ERA-10001', 'CUST-001', 'siti@example.com',   'delivered',  2499000, now() - interval '31 days'),
    ('ERA-10002', 'CUST-001', 'siti@example.com',   'delivered',   189000, now() - interval '18 days'),
    ('ERA-10003', 'CUST-001', 'siti@example.com',   'shipped',   18999000, now() - interval '2 days'),
    ('ERA-10004', 'CUST-002', 'bagus@example.com',  'cancelled',  3450000, now() - interval '12 days'),
    ('ERA-10005', 'CUST-002', 'bagus@example.com',  'delivered',   750500, now() - interval '9 days'),
    ('ERA-10006', 'CUST-003', 'rina@example.com',   'placed',     1200000, now() - interval '4 hours'),
    ('ERA-10007', 'CUST-003', 'rina@example.com',   'delivered', 24500000, now() - interval '63 days'),
    ('ERA-10008', 'CUST-004', 'andi@example.com',   'packed',       99000, now() - interval '1 day'),
    ('ERA-10009', 'CUST-004', 'andi@example.com',   'cancelled',   560000, now() - interval '20 days'),
    ('ERA-10010', 'CUST-005', 'maya@example.com',   'delivered',  7320000, now() - interval '6 days');

INSERT INTO order_lines (order_id, sku, quantity, unit_price_idr) VALUES
    ('ERA-10001', 'IPH-15-128-BLK',  1,  2499000),
    ('ERA-10002', 'CBL-USBC-1M',     2,    89000),
    ('ERA-10002', 'CSE-IPH15-CLR',   1,    11000),
    ('ERA-10003', 'MBP-M4-14-512',   1, 18999000),
    ('ERA-10004', 'SAM-S24-256-GRY', 1,  3450000),
    ('ERA-10005', 'EAR-BUDS3-WHT',   1,   750500),
    ('ERA-10006', 'WCH-SE2-44-SLV',  1,  1200000),
    ('ERA-10007', 'MBA-M3-13-256',   1, 17500000),
    ('ERA-10007', 'IPD-A11-64-BLU',  1,  7000000),
    ('ERA-10008', 'CBL-LTN-2M',      1,    99000),
    ('ERA-10009', 'PWR-20K-BLK',     2,   280000),
    ('ERA-10010', 'IPD-PRO-11-128',  1,  7320000);
