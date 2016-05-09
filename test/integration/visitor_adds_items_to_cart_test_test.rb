require 'test_helper'

class VisitorAddsItemsToCartTestTest < ActionDispatch::IntegrationTest
  test "visitor can add items to their cart from items index" do
    create_categories(2)
    create_items(4)

    visit '/items'
    within ".nav" do
      assert page.has_content? "0"
    end

    first(:button, "Add to Cart").click

    assert page.has_content? "Successfully added to cart!"

    within ".nav" do
      assert page.has_content? "1"
    end
  end
end
