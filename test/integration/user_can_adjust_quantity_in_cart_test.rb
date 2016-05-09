require 'test_helper'

class UserCanAdjustQuantityInCartTest < ActionDispatch::IntegrationTest

  test "test user can adjust item quantity when items are already in cart" do
    create_categories
    create_items
    item = Item.first

    visit '/items'

    within ".nav" do
      assert page.has_content? "0"
    end

    click_button "Add to Cart"

    assert page.has_content? "Successfully added to cart!"

    within ".nav" do
      assert page.has_content? "1"
    end
    visit '/cart'

    assert_equal '/cart', current_path
    assert page.has_content? "#{item.name}"
    assert_equal "1", page.find_field("session[quantity]").value

    fill_in "session[quantity]", with: "2"
    click_button "Update Quantity"

    assert_equal '/cart', current_path

    assert page.has_content? "#{item.name}"
    assert_equal "2", page.find_field("session[quantity]").value
    assert page.has_content? "Subtotal: $#{item.price * 2}"
    assert page.has_content? "TOTAL $#{item.price * 2}"

  end
end
