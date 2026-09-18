from __future__ import annotations

import re
import uuid

from .models import Order, OrderLine, OrderStatus

EMAIL = re.compile(r"^[^@\s]+@[^@\s]+\.[^@\s]+$")

ALLOWED: dict[OrderStatus, set[OrderStatus]] = {
    OrderStatus.PLACED: {OrderStatus.PACKED, OrderStatus.CANCELLED},
    OrderStatus.PACKED: {OrderStatus.SHIPPED, OrderStatus.CANCELLED},
    OrderStatus.SHIPPED: {OrderStatus.DELIVERED},
    OrderStatus.DELIVERED: set(),
    OrderStatus.CANCELLED: set(),
}


class OrderNotFound(Exception):
    """Raised when an order id does not exist."""


class InvalidTransition(Exception):
    """Raised when a status change is not allowed from the current status."""


class InvalidOrder(Exception):
    """Raised when an order cannot be created from the data given."""


class OrderService:
    """In-memory order tracking.

    Storage is deliberately a dict: the spec has not decided on a database
    yet, and the labs are about the workflow, not about persistence.
    """

    def __init__(self) -> None:
        self._orders: dict[str, Order] = {}

    def create_order(
        self, customer_email: str, lines: list[OrderLine]
    ) -> Order:
        if not EMAIL.match(customer_email):
            raise InvalidOrder(f"not a valid email address: {customer_email!r}")
        if not lines:
            raise InvalidOrder("an order needs at least one line")
        if any(line.quantity < 1 for line in lines):
            raise InvalidOrder("every line needs a quantity of 1 or more")

        order = Order(
            order_id=uuid.uuid4().hex[:12],
            customer_email=customer_email.lower(),
            lines=list(lines),
        )
        self._orders[order.order_id] = order
        return order

    def get_order(self, order_id: str) -> Order:
        try:
            return self._orders[order_id]
        except KeyError as exc:
            raise OrderNotFound(order_id) from exc

    def update_status(self, order_id: str, new_status: OrderStatus) -> Order:
        order = self.get_order(order_id)
        if new_status not in ALLOWED[order.status]:
            raise InvalidTransition(
                f"{order.status.value} -> {new_status.value} is not allowed"
            )
        order.status = new_status
        return order

    def list_for_customer(self, customer_email: str) -> list[Order]:
        wanted = customer_email.lower()
        found = [o for o in self._orders.values() if o.customer_email == wanted]
        return sorted(found, key=lambda o: o.created_at, reverse=True)
