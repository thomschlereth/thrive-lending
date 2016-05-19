require "rails_helper"

RSpec.feature "User checkout creates contract" do

  before(:each) do
    @user1, @user2 = create_user(2)
    @loan_request = create_loan_request(1, @user1.id).first
    @loan_offer = create_loan_offer(1, @user1.id).first
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.last)
  end

  scenario "existing user can checkout cart" do
    visit loan_requests_path
    click_on "Add To Cart"
    visit loan_offers_path
    click_on "Add To Cart"

    visit cart_path
    click_on "Place Order"

    expect(current_path).to eq(new_contract_path)
    expect(page).to have_content ActionController::Base.helpers.number_to_currency(@loan_offer.amount)
    expect(page).to have_content @loan_offer.term
    expect(page).to have_content @loan_offer.rate

    expect(page).to have_content ActionController::Base.helpers.number_to_currency(@loan_request.amount)
    expect(page).to have_content @loan_request.term
    expect(page).to have_content @loan_request.rate

    click_button "Submit"
    contract1 = Contract.first
    contract2 = Contract.last
    expect(current_path).to eq(user_contracts_path(@user2.username))
    expect(page).to have_content ActionController::Base.helpers.number_to_currency(contract1.loan_request.amount)
    expect(page).to have_content contract1.loan_request.term
    expect(page).to have_content contract1.loan_request.rate
    expect(page).to have_content ActionController::Base.helpers.number_to_currency(contract2.loan_offer.amount)
    expect(page).to have_content contract2.loan_offer.term
    expect(page).to have_content contract2.loan_offer.rate
    expect(page).to have_content "Pending"
  end
end
