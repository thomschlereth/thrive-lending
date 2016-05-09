require "test_helper"

class AdminCanEditItemsTest < ActionDispatch::IntegrationTest
  test "admin can edit an item" do
    admin = User.create(first_name: "Kris",
                        last_name: "Foss",
                        email: "kris.foss@gmail.com",
                        password: "password",
                        role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    create_categories(2)
    create_items
    item = Item.first
    visit admin_items_path

    assert page.has_content?(item.name)
    assert page.has_content?(item.description)
    assert page.has_content?("false")
    refute page.has_content?("Bronto Burgers")
    refute page.has_content?("Yum, meaty")
    refute page.has_content?("true")

    click_on "Edit"

    assert items_path, "/admin/items/:item_id/edit"

    fill_in "Name", with: "Bronto Burgers"
    fill_in "Description", with: "Yum, meaty"
    click_on "Update Item"

    assert page.has_content?("Bronto Burgers")
    assert page.has_content?("Yum, meaty")
  end
end
