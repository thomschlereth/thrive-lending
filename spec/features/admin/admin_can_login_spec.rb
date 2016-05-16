require "rails_helper"

RSpec.feature "Admin can login" do
  scenario "existing admin logs into account" do
    create_user(1,1)
    admin = User.first

    visit '/login'
    fill_in "Username", with: admin.username
    fill_in "Password", with: "password"
    click_on "Log in"

    expect(current_path).to eq("/admin/dashboard")
    expect(page).to have_content("Welcome Administrator: #{admin.first_name}")
    expect(page).to_not have_link("Log In")
    expect(page).to have_link("Log Out")
  end

  scenario "types wrong password" do
    create_user(1,1)
    admin = User.first

    visit login_path
    fill_in "Username", with: admin.username
    fill_in "Password", with: "wrong"
    click_on "Log in"
    expect(current_path).to eq(login_path)
    expect(page).to have_content "Invalid Credentials"
  end

  scenario "types wrong username" do
    create_user(1,1)
    admin = User.first

    visit login_path
    fill_in "Username", with: "wrong"
    fill_in "Password", with: admin.password
    click_on "Log in"

    expect(current_path).to eq(login_path)
    expect(page).to have_content "Invalid Credentials"
  end

  scenario "admin can log out" do
    create_user(1,1)
    admin = User.first

    visit '/login'
    fill_in "Username", with: admin.username
    fill_in "Password", with: "password"
    click_on "Log in"
    click_on "Log Out"

    expect(current_path).to eq(root_path)
    expect(page).to have_link "Log In"
    expect(page).to_not have_link "Log Out"
  end

end
