# Request and response patterns

## Create an order

```
POST /orders
{
  "customer_email": "dimas@example.com",
  "lines": [{"sku": "PHONE-13", "quantity": 1, "unit_price": 8999000}]
}

201 Created
{
  "order_id": "9f2c1ab4d5e6",
  "status": "placed",
  "total": 8999000
}
```

## Move an order forward

```
PATCH /orders/9f2c1ab4d5e6
{"status": "packed"}

409 Conflict
{"error": {"code": "invalid_transition", "message": "placed -> shipped is not allowed"}}
```

## Customer history

```
GET /orders?customer_email=dimas@example.com

200 OK
{"orders": [ ... newest first ... ]}
```
