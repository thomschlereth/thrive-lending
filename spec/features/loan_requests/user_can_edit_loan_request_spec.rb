require "rails_helper"

RSpec.feature "User can edit a loan request" do

    before(:each) do
        create_user(2)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)
    end

  scenario "existing user can edit loan request" do
    user = User.first
    create_loan_request(1, user.id)
    request = LoanRequest.last

    visit user_loan_request_path(user.username, request.id)

    click_on "Edit request"
    fill_in "Amount in Dollars:", with: "3000"
    fill_in "Rate:", with: "20"
    click_on "That was easy"

    request = LoanRequest.last

    expect(current_path).to eq(user_loan_request_path(user.username, request.id))
    expect(page).to have_content(ActionController::Base.helpers.number_to_currency(request.amount))
    expect(page).to have_content(request.rate)
  end
end
