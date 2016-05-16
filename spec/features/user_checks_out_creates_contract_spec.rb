require "rails_helper"

RSpec.feature "User checkout creates contract" do

     before(:each) do
        create_user(2)
        owner = User.last
        create_loan_request(1, owner.id)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)
    end

    scenario "existing user can checkout cart" do
        user = User.first
        visit loan_requests_path
        click_on "Add To Cart"
        visit cart_path
        click_on "Place Order"

        expect(current_path).to eq(new_contract_path)

        click_button "Submit"

        contract = Contract.last.loan_request

        expect(current_path).to eq(user_contracts_path(user.username))
        expect(page).to have_content ActionController::Base.helpers.number_to_currency(contract.amount)
        expect(page).to have_content contract.term
        expect(page).to have_content contract.rate
        expect(page).to have_content "Pending"
    end
end
