from __future__ import annotations

import pytest

from src.orders import InvalidTransition, OrderNotFound, OrderService
from src.orders.models import OrderLine, OrderStatus
from src.orders.service import InvalidOrder


@pytest.fixture()
def service() -> OrderService:
    return OrderService()


@pytest.fixture()
def lines() -> list[OrderLine]:
    return [OrderLine(sku="PHONE-13", quantity=1, unit_price=8_999_000)]


def test_valid_order_is_created_and_starts_as_placed(service, lines):
    order = service.create_order("dimas@example.com", lines)

    assert order.order_id
    assert order.status is OrderStatus.PLACED
    assert order.total == 8_999_000


def test_email_is_normalised_to_lowercase(service, lines):
    order = service.create_order("Dimas@Example.COM", lines)

    assert order.customer_email == "dimas@example.com"


def test_invalid_email_is_rejected(service, lines):
    with pytest.raises(InvalidOrder):
        service.create_order("not-an-email", lines)


def test_order_without_lines_is_rejected(service):
    with pytest.raises(InvalidOrder):
        service.create_order("dimas@example.com", [])


def test_unknown_order_id_raises(service):
    with pytest.raises(OrderNotFound):
        service.get_order("does-not-exist")


def test_status_moves_forward_through_the_allowed_path(service, lines):
    order = service.create_order("dimas@example.com", lines)

    service.update_status(order.order_id, OrderStatus.PACKED)
    service.update_status(order.order_id, OrderStatus.SHIPPED)
    updated = service.update_status(order.order_id, OrderStatus.DELIVERED)

    assert updated.status is OrderStatus.DELIVERED


def test_skipping_a_status_is_rejected(service, lines):
    order = service.create_order("dimas@example.com", lines)

    with pytest.raises(InvalidTransition):
        service.update_status(order.order_id, OrderStatus.SHIPPED)


def test_delivered_order_cannot_be_cancelled(service, lines):
    order = service.create_order("dimas@example.com", lines)
    for status in (OrderStatus.PACKED, OrderStatus.SHIPPED, OrderStatus.DELIVERED):
        service.update_status(order.order_id, status)

    with pytest.raises(InvalidTransition):
        service.update_status(order.order_id, OrderStatus.CANCELLED)


def test_customer_history_is_newest_first(service, lines):
    first = service.create_order("dimas@example.com", lines)
    second = service.create_order("dimas@example.com", lines)
    service.create_order("someone.else@example.com", lines)

    history = service.list_for_customer("DIMAS@example.com")

    assert [o.order_id for o in history] == [second.order_id, first.order_id]
