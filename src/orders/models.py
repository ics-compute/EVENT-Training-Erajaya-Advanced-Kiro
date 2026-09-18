from __future__ import annotations

from dataclasses import dataclass, field
from datetime import datetime, timezone
from enum import Enum


class OrderStatus(str, Enum):
    """The states an order can be in, in the order they normally happen."""

    PLACED = "placed"
    PACKED = "packed"
    SHIPPED = "shipped"
    DELIVERED = "delivered"
    CANCELLED = "cancelled"


@dataclass
class OrderLine:
    sku: str
    quantity: int
    unit_price: int  # minor units, so no float rounding surprises


@dataclass
class Order:
    order_id: str
    customer_email: str
    lines: list[OrderLine]
    status: OrderStatus = OrderStatus.PLACED
    created_at: datetime = field(
        default_factory=lambda: datetime.now(timezone.utc)
    )

    @property
    def total(self) -> int:
        return sum(line.quantity * line.unit_price for line in self.lines)
