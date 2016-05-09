require "test_helper"

class AdminCanLoginTest < ActionDispatch::IntegrationTest
  test "admin can create a new item" do
    create_user(1, 1)
    admin = User.first

    visit '/login'
    fill_in "E-Mail", with: admin.email
    fill_in "Password", with: "password"
    click_button "Log in"

    within "h1" do
      assert page.has_content? "Welcome Administrator : #{admin.first_name}"
    end
  end
end
