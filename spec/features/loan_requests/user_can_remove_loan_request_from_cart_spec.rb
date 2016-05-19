require "rails_helper"

RSpec.feature "User can remove loan requests from cart" do

    before(:each) do
        create_user(2)
        owner = User.last
        create_loan_request(1, owner.id)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)

    end

    scenario "user can remove a loan request from their cart" do
        request = LoanRequest.last

        visit "/loan_requests"
        click_on "Add To Cart"
        visit cart_path
        click_button("X")

        expect(page).to_not have_content ActionController::Base.helpers.number_to_currency(request.amount)
        expect(page).to_not have_content request.rate
    end

end
