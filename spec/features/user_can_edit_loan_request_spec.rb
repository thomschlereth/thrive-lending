require "rails_helper"

RSpec.feature "User can edit a loan request" do


    before(:each) do
        create_user(2)
        ApplicationController.any_instance.stub(:current_user).and_return(User.first)
    end

  scenario "existing user can edit loan request" do
    user = User.first
    create_loan_request(1, user.id)
    request = LoanRequest.last

    visit user_loan_request_path(user.username, request.id)

    click_on "Edit Request"    
    fill_in "Loan Amount", with: "3000"
    fill_in "Maximum Interest Rate", with: "20"
    click_on "Edit Loan Request"

    request = LoanRequest.last
    
    expect(current_path).to eq(user_loan_request_path(user.username, request.id))
    expect(page).to have_content(request.amount)
    expect(page).to have_content(request.max_int_rate)
  end
end
