  require 'test_helper'

class UserCanLoginTest < ActionDispatch::IntegrationTest
  test "user can login with valid credentials" do
    create_user
    user = User.first
    visit '/login'
    fill_in "E-Mail", with: user.email
    fill_in "Password", with: "password"
    click_button "Log in"

    assert_equal "/dashboard", current_path

    assert page.has_content? "Logged in as #{user.first_name}"
    assert page.has_content? user.email
    assert page.has_content? user.city
    assert page.has_content? user.state
    assert page.has_content? user.zipcode
    refute page.has_link? "Login"
    assert page.has_button? "Logout"

  end
end
