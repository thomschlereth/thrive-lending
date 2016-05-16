require "rails_helper"

RSpec.feature "User can add loan offers to cart" do

     before(:each) do
        create_user(2)
        owner = User.last
        create_loan_offer(1, owner.id)
        ApplicationController.any_instance.stub(:current_user).and_return(User.first)
    end

    scenario "user can add a loan offer to their cart" do
        offer = LoanOffer.last

        visit "/loan_offers"
        click_on "Add To Cart"

        visit cart_path

        expect(page).to have_content ActionController::Base.helpers.number_to_currency(offer.amount)
        expect(page).to have_content offer.rate
    end

    scenario "user cannot add a loan offer to their cart twice" do
        offer = LoanOffer.last

        visit loan_offers_path

        click_on "Add To Cart"
        click_on "Add To Cart"

        expect(page).to have_content "Loan is already in cart."
    end
end
