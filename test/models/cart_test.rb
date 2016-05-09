require "test_helper"

class CartTest < ActiveSupport::TestCase
  def test_add_item_to_cart
    cart = Cart.new({})
    cart.add_item(1)
    assert_equal ({ "1" => 1 }), cart.contents
  end

  def test_count_all_items_in_cart
    cart = Cart.new({})
    3.times do
      cart.add_item(1)
    end
    assert_equal 3, cart.count_all
  end

  def test_count_of_a_single_item
    cart = Cart.new({})
    2.times do
      cart.add_item(1)
    end
    cart.add_item(2)
    assert_equal 3, cart.count_all
    assert_equal 2, cart.count_of(1)
  end

  def test_remove_item_from_cart
    cart = Cart.new({})
    2.times do
      cart.add_item(1)
    end
    cart.add_item(2)
    assert_equal 3, cart.count_all
    cart.remove_item(1)
    assert 1, cart.count_all
  end

  def test_update_item_in_cart
    cart = Cart.new({})
    cart.add_item(1)
    cart.update(1, 2)
    assert_equal 2, cart.count_all
  end

  def test_total_price_of_cart
    create_categories
    create_items(2)
    item1 = Item.first
    item2 = Item.last
    cart = Cart.new({})
    2.times do
      cart.add_item(item1.id)
    end
    cart.add_item(item2.id)

    expected = ((item1.price * 2) + item2.price)
    assert_equal expected, cart.total_price
  end
end
