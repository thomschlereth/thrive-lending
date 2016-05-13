require "rails_helper"

RSpec.feature "User can create a loan offer" do

    before(:each) do
        create_user(2)
        ApplicationController.any_instance.stub(:current_user).and_return(User.first)
    end

  scenario "existing user can create loan offer" do
    user = User.first

    visit dashboard_path(user)

    click_on "Create a Loan Offer"

    assert_equal new_loan_offer_path, current_path

    fill_in "Amount in Dollars:", with: "3000"
    fill_in "Rate as a Percentage:", with: "20"
    fill_in "Term in Months:", with: "18"
    click_on "Let's Go!"

    offer = LoanOffer.last

    assert_equal "/#{user.username}/loan_offers/#{offer.id}", current_path
    assert page.has_content? offer.amount
    assert page.has_content? offer.rate
    assert page.has_content? offer.term

  end
end
