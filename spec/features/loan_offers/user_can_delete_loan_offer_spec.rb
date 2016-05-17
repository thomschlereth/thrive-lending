require "rails_helper"

RSpec.feature "User can delete a loan offer" do


    before(:each) do
        create_user(2)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)
    end

  scenario "existing user can delete loan offer" do
    user = User.first
    create_loan_offer(1, user.id)
    offer = LoanOffer.last

    visit user_loan_offer_path(user.username, offer.id)

    click_on "Delete offer"    

    visit user_loan_offers_path(user.username)

    expect(page).to have_no_content(offer.amount)
    expect(page).to have_no_content(offer.rate)
    expect(page).to have_no_content(offer.term)
  end
end
