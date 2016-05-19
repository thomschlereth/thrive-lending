require "rails_helper"

RSpec.feature "User can edit a loan offer" do

    before(:each) do
        create_user(2)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)
    end

  scenario "existing user can edit loan offer" do
    user = User.first
    create_loan_offer(1, user.id)
    offer = LoanOffer.last

    visit user_loan_offer_path(user.username, offer.id)

    click_on "Edit offer"
    fill_in "loan_offer_amount", with: "2400"
    fill_in "loan_offer_rate", with: "12"
    fill_in "loan_offer_term", with: "24"
    click_on "That was easy"

    offer = LoanOffer.last

    expect(current_path).to eq(user_loan_offer_path(user.username, offer.id))
    expect(page).to have_content(ActionController::Base.helpers.number_to_currency(offer.amount))
    expect(page).to have_content(offer.rate)
    expect(page).to have_content(offer.term)
  end
end
