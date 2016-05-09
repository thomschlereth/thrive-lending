require "test_helper"

class RemoveItemFromCartTest < ActionDispatch::IntegrationTest
  test "visitor can remove item from cart" do
    create_categories
    create_items
    item = Item.first
    visit "/items"
    click_button "Add to Cart"
    visit "/cart"
    click_button "X"
    assert "/cart", current_path
    assert page.has_content? "Successfully removed #{item.name}!"
    assert page.has_link? "#{item.name}"
    assert "/cart", current_path
  end
end
