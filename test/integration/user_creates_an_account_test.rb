require 'test_helper'

class UserCreatesAnAccountTest < ActionDispatch::IntegrationTest
  test "user can create and account" do

    user_info = {first_name: Faker::Name.first_name,
                 last_name: Faker::Name.last_name,
                 email: Faker::Internet.safe_email,
                 address: Faker::Address.street_address,
                 city: Faker::Address.city,
                 state: Faker::Address.state_abbr,
                 zipcode: Faker::Address.zip_code,
                 password: "password"}

    visit '/login'
    click_on "Create Account"

    fill_in "First Name", with: user_info[:first_name]
    fill_in "Last Name", with: user_info[:last_name]
    fill_in "Street Address", with: user_info[:address]
    fill_in "City", with: user_info[:city]
    fill_in "State", with: user_info[:state]
    fill_in "Zip Code", with: user_info[:zipcode]
    fill_in "E-Mail", with: user_info[:email]
    fill_in "Password", with: user_info[:password]
    click_button "Create Account"
    click_link "Dashboard"

    # assert page.has_content?("Logged in as #{user_info[:first_name]} #{user_info[:last_name]}")
    assert page.has_content?(user_info[:email])
    assert page.has_content?(user_info[:address])
    assert page.has_content?(user_info[:city])
    assert page.has_content?(user_info[:state])

    refute page.has_link?("Login")

    assert page.has_button?("Logout")
    click_button "Logout"

    assert page.has_link?("Login")
  end
end
