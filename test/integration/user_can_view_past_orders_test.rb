require 'test_helper'

class UserCanViewPastOrdersTest < ActionDispatch::IntegrationTest
  test "the user can view their past orders" do
    create_user(2)
    gerry = User.first
    carissa = User.last
    create_orders(2, gerry.id)
    create_orders(1, carissa.id)

    ApplicationController.any_instance.stubs(:current_user).returns(gerry)

    visit '/orders'
    assert page.has_content?("Order number : #{Order.first.id}")
    refute page.has_content?("Order number : #{Order.last.id}")

  end
end
