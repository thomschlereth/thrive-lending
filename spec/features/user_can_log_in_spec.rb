require "rails_helper"

RSpec.feature "User can login" do
  scenario "existing user logs into account" do
    create_user
    user = User.first

    visit '/login'
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_on "Log in"

    assert_equal "/dashboard", current_path
    assert page.has_content? "Hello, #{user.first_name}"
    refute page.has_link? "Log In"
    assert page.has_button? "Log Out"
  end

  scenario "types wrong password" do
    create_user
    user = User.first

    visit login_path
    fill_in "Username", with: user.email
    fill_in "Password", with: "wrong"
    click_on "Log in"
    assert_equal login_path, current_path
    # expect(page).to have_content "Invalid Credentials"
  end

  scenario "types wrong username" do
    create_user
    user = User.first

    visit login_path
    fill_in "Username", with: "wrong"
    fill_in "Password", with: user.password
    click_on "Log in"

    assert_equal login_path, current_path
    # expect(page).to have_content "Invalid Credentials"

  end
end
