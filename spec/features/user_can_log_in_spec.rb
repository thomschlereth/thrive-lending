require "rails_helper"

RSpec.feature "User can login" do
  scenario "existing user logs into account" do
    create_user
    user = User.first

    visit '/login'
    fill_in "E-Mail", with: user.email
    fill_in "Password", with: "password"
    click_on "Log in"

    assert_equal "/dashboard", current_path

    assert page.has_content? "Logged in as #{user.first_name}"
    assert page.has_content? user.email
    assert page.has_content? user.city
    assert page.has_content? user.state
    assert page.has_content? user.zipcode
    
    refute page.has_link? "Login"
    assert page.has_button? "Logout"
  end

  scenario "types wrong password" do
    create_user
    user = User.first

    visit login_path
    fill_in "E-Mail", with: user.email
    fill_in "Password", with: "wrong"
    click_on "Login"
    assert_equal login_path, current_path
    # expect(page).to have_content "Invalid Credentials"
  end

  scenario "types wrong username" do
    create_user
    user = User.first

    visit login_path
    fill_in "E-Mail", with: "wrong"
    fill_in "Password", with: user.password
    click_on "Login"

    assert_equal login_path, current_path
    # expect(page).to have_content "Invalid Credentials"

  end
end
