require "rails_helper"

RSpec.feature "User can view own loan offers" do
   
   before(:each) do
        create_user(2)
        ApplicationController.any_instance.stub(:current_user).and_return(User.first)
    end

  scenario "existing user can view their loan offers" do
    user = User.first
    create_loan_offer(2)
    user.loan_offers = LoanOffer.all
    offer = user.loan_offers.first

    visit '/dashboard'
    click_on "View My Loan Offers"

    expect(page).to have_content ActionController::Base.helpers.number_to_currency(offer.amount)
    expect(page).to have_content offer.rate
    expect(page).to have_content offer.term

  end
end
