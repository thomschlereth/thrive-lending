require "rails_helper"

RSpec.feature "User can create a loan request" do
  scenario "existing user can create loan request" do
    create_user
    user = User.last

    visit '/login'
    fill_in "E-Mail", with: user.email
    fill_in "Password", with: "password"
    click_on "Log in"

    assert_equal "/dashboard", current_path

    click_on "Create a Loan Request"

    assert_equal new_loan_request_path, current_path

    fill_in "Loan Amount", with: "3000"
    fill_in "Maximum Interest Rate", with: "20"
    click_on "Submit Loan Request"
    
    request = LoanRequest.last

    assert_equal "/#{user.username}/loan_requests/#{request.id}", current_path
    assert page.has_content? request.amount
    assert page.has_content? request.max_int_rate
  
  end
end