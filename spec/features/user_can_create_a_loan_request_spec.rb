require "rails_helper"

RSpec.feature "User can create a loan request" do
  scenario "existing user can create loan request" do
    create_user
    user = User.last

    visit '/login'
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_on "Log in"

    assert_equal "/dashboard", current_path

    click_on "Create a Loan Request"

    assert_equal new_loan_request_path, current_path

    fill_in "Amount in Dollars:", with: "3000"
    fill_in "Max Interest Rate", with: "20"
    click_on "Let's Go!"

    request = LoanRequest.last
    assert_equal "/#{user.username}/loan_requests/#{request.id}", current_path
    assert page.has_content? ActionController::Base.helpers.number_to_currency(request.amount)
    assert page.has_content? request.max_int_rate

  end
end
