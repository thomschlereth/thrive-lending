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

    expect(current_path).to eq(new_loan_offer_path)

    fill_in "Amount in Dollars:", with: "3000"
    fill_in "Rate as a Percentage:", with: "20"
    fill_in "Term in Months:", with: "18"
    click_on "Let's Go!"

    offer = LoanOffer.last

    expect(current_path).to eq("/#{user.username}/loan_offers/#{offer.id}")
    expect(page).to have_content ActionController::Base.helpers.number_to_currency(offer.amount)
    expect(page).to have_content offer.rate
    expect(page).to have_content offer.term

  end
end
