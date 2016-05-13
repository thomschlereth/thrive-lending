require "rails_helper"

RSpec.feature "User can view all loan offers" do

    before(:each) do
        create_user(2)
        ApplicationController.any_instance.stub(:current_user).and_return(User.first)
    end

    scenario "existing user can create loan offer" do
        user = User.first
        create_loan_offer(2)
        user.loan_offers = LoanOffer.all
        offer = user.loan_offers.last

        user1 = User.last
        create_loan_offer
        user1.loan_offers << LoanOffer.last
        offer1 = user1.loan_offers.last

        visit loan_offers_path

        assert page.has_content? offer.amount
        assert page.has_content? offer.term
        assert page.has_content? offer1.amount
        assert page.has_content? offer1.term


    end
end