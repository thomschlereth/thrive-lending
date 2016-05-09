require 'test_helper'

class AdminCanCreateItemsTest < ActionDispatch::IntegrationTest
  test "admin can create a new item" do
    admin = User.create(first_name: "Kris",
    last_name: "Foss",
    email: "kris.foss@gmail.com",
    city: "Denver",
    state: "CO",
    zipcode: "80123",
    password: "password",
    role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    create_categories(3)

    visit admin_dashboard_path
    click_on "Create New Items"

    assert page.has_content?("Item Creation Page")
    fill_in "Name", with: "Bronto Burgers"
    fill_in "Description", with: "Yum, meaty"
    fill_in "Price", with: 6.00
    fill_in "Category ID", with: Category.first.id
    click_button "Create Item"

    assert items_path, current_path

    assert page.has_content?("Bronto Burgers")

    assert page.has_content?("Yum, meaty")

    assert page.has_content?("6.00")
  end
end
