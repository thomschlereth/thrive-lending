require "rails_helper"

RSpec.feature "User can delete a loan request" do


    before(:each) do
        create_user(2)
        ApplicationController.any_instance.stub(:current_user).and_return(User.first)
    end

  scenario "existing user can delete loan request" do
    user = User.first
    create_loan_request(1, user.id)
    request = LoanRequest.last

    visit user_loan_request_path(user.username, request.id)
    click_on "Delete Loan Request"    

    visit user_loan_requests_path(user.username)
    
    expect(page).to have_no_content(request.amount)
    expect(page).to have_no_content(request.max_int_rate)
  end
end
