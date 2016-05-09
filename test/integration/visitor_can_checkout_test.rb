require 'test_helper'

class VisitorCanCheckoutTest < ActionDispatch::IntegrationTest
  test "visitor can view checkout" do
    create_categories
    create_items
    visit items_path
    click_button "Add to Cart"
    find(:xpath, "//a[@href='/cart']").click
    refute page.has_button? "Place Order"
    click_button "Login to Checkout"
    click_link "Create Account"
    fill_in "First Name", with: "Mark"
    fill_in "Last Name", with: "Miranda"
    fill_in "E-Mail", with: "markmiranda51@gmail.com"
    fill_in "Street Address", with: "123 Fake Street"
    fill_in "City", with: "Denver"
    fill_in "State", with: "CO"
    fill_in "Zip Code", with: "80219"
    fill_in "Password", with: "password"
    click_button "Create Account"
    find(:xpath, "//a[@href='/cart']").click
    click_button "Place Order"
    assert page.has_content? "Order was successfully placed"

  end
end
