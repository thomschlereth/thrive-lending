require 'test_helper'

class VisitorCanViewCartTest < ActionDispatch::IntegrationTest
  test "visitor can view items in cart" do

    create_categories
    item = Item.create(name: "Dino Snackies",
      description: "Better than goldfish",
      price: 10.00,
      category_id: Category.first.id )

    visit '/items'
    click_button "Add to Cart"
    click_button "Add to Cart"
    click_link "Cart"
    assert_equal '/cart', current_path
    assert page.has_content? "Dino Snackies"
    assert page.has_content? "$10.00"
    assert_equal "2", page.find_field("session[quantity]").value
    assert page.has_content? "TOTAL $20.00"
  end
end
