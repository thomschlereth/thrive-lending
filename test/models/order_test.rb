require "test_helper"

class OrderTest < ActiveSupport::TestCase
  should validate_presence_of(:user_id)

  def test_create_time_formats_time_create
    create_user
    user = User.first
    date = Date.new(2016, 04, 26)
    order = Order.create(user_id: user.id, status: "ordered", created_at: date)
    expected = "Tuesday, Apr 26, 2016"
    assert_equal expected, Order.format_time(order.created_at)
  end

  def test_update_time_formats_time_create
    create_user
    user = User.first
    date = Date.new(2016, 04, 26)
    order = Order.create(user_id: user.id, status: "ordered", updated_at: date)
    expected = "Tuesday, Apr 26, 2016"
    assert_equal expected, order.update_time
  end

  def test_total_price_returns_sum_of_subtotals
    create_user
    create_categories
    create_items
    create_orders
    item = Item.first
    order = Order.first
    OrderItem.create(order_id: order.id,
                     item_id:  item.id,
                     quantity: 2)
    expected = (item.price * 2)
    assert_equal expected, order.total_price
  end
end
