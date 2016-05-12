  require 'test_helper'

class UserCanLoginTest < ActionDispatch::IntegrationTest

    test "user can login with valid credentials" do
    create_user
    user = User.first
    visit '/login'
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_button "Log in"

    assert_equal "/dashboard", current_path

    assert page.has_content? "Logged in as #{user.first_name}"
    assert page.has_content? user.email
    assert page.has_content? user.city
    assert page.has_content? user.state
    assert page.has_content? user.zipcode
    refute page.has_link? "Log In"
    assert page.has_link? "Log Out"

    click_link "Log Out"
    assert page.has_link? "Log In"
    assert_equal nil, @current_user
  end
end
