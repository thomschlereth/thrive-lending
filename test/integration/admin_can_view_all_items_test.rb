require "test_helper"

class AdminCanViewAllItemsTest < ActionDispatch::IntegrationTest
  test "admin can view all items" do
    admin = User.create(first_name: "Kris",
    last_name: "Foss",
    email: "kris.foss@gmail.com",
    city: "Denver",
    state: "CO",
    zipcode: "80123",
    password: "password",
    role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    create_categories
    create_items(2)
    item1 = Item.first
    item2 = Item.last
    visit admin_dashboard_path
    click_on "Items"
    assert_equal "/admin/items", current_path

    assert page.has_content?

    assert page.has_content? "All Items"

    within ".item#{item1.id}" do
      assert page.has_content? item1.name
      assert page.has_content? item1.description
      assert page.has_content? item1.retired
      assert page.has_content? "Edit"
    end

    within ".item#{item2.id}"  do
      assert page.has_content? item2.name
      assert page.has_content? item2.description
      assert page.has_content? item2.retired
      assert page.has_content? "Edit"
    end
  end
end
