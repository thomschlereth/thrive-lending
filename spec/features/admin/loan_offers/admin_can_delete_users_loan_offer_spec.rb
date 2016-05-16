require "rails_helper"

RSpec.feature "Logged in admin can delete users loan offer" do
  before(:each) do
    create_user(1,1)
    @admin,@user1 = create_user(1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)

    @loan_offer1,@loan_offer2,@loan_offer3  = create_loan_offer(3,@user1.id)
  end

  scenario "when they click delete button on loan offer page" do
    expect(@user1.loan_offers.count).to eq(3)
    visit user_loan_offer_path(@user1.username, @loan_offer1.id)

    click_button "Delete offer"

    expect(current_path).to eq(user_path(@user1.username))
    expect(@user1.loan_offers.count).to eq(2)
  end
end
