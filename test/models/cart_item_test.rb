require "test_helper"

class CartItemTest < ActiveSupport::TestCase

  def test_subtotal_returns_correct_amount
    create_categories
    create_items
    item = Item.first
    ci = CartItem.new(item.id, 3)

    expected = item.price * 3
    assert_equal expected, ci.subtotal
  end
end
