require "test_helper"

class OrderItemTest < ActiveSupport::TestCase
  should validate_presence_of(:order_id)
  should validate_presence_of(:item_id)
  should validate_presence_of(:quantity)

  def test_subtotal_returns_correct_amount
    create_user
    create_categories
    create_items
    create_orders
    item = Item.first
    order = Order.first
    oi = OrderItem.create(order_id: order.id, item_id: item.id, quantity: 3)

    expected = item.price * 3
    assert_equal expected, oi.subtotal
  end
end
