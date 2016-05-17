require "rails_helper"

RSpec.feature "User can add loan requests to cart" do

    before(:each) do
        create_user(2)
        owner = User.last
        create_loan_request(1, owner.id)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)

    end

    scenario "user can add a loan request to their cart" do
        request = LoanRequest.last

        visit "/loan_requests"
        click_on "Add To Cart"
        visit cart_path


        expect(page).to have_content ActionController::Base.helpers.number_to_currency(request.amount)
        expect(page).to have_content request.rate
    end

    scenario "user cannot add a loan request to their cart twice" do
        request = LoanRequest.last

        visit loan_requests_path

        click_on "Add To Cart"
        click_on "Add To Cart"

        expect(page).to have_content "Loan is already in cart."
    end
end
        
