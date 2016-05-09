require 'test_helper'

class UserCannotAddRetiredItemToCartTest < ActionDispatch::IntegrationTest
  test "user cannot add retired item to cart" do
    create_categories
    create_items(1, true)
    item = Item.first
    visit item_path(item)
    assert page.has_button? "Item Retired", disabled: true
  end
end
