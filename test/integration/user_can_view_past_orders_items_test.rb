require 'test_helper'

class UserCanViewPastOrdersItemsTest < ActionDispatch::IntegrationTest
  test "the user can view their past orders items" do
    create_user
    user = User.first
    create_orders(1, user.id, "completed")
    order = Order.first
    create_categories
    create_items
    OrderItem.create(order_id: Order.first.id,
                     item_id: Item.first.id,
                     quantity: 2)

    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit '/orders'
    assert page.has_content?("Order number : #{order.id}")
    assert page.has_link?("View Order Details")
    click_link "View Order Details"
    assert page.has_content?("#{order.items.first.name}")
    assert page.has_link?("#{order.items.first.name}")
    assert page.has_content?("#{OrderItem.first.quantity}")
    assert page.has_content?(OrderItem.first.subtotal)
    assert page.has_content?("completed")
    assert page.has_content?(order.total_price)
    assert page.has_content?(Order.format_time(order.created_at))
    assert page.has_content?("Order Status: #{order.status}")
    assert page.has_content?("#{order.update_time}")
  end
end
