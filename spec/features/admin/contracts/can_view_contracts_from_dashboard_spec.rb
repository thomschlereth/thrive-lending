require "rails_helper"

RSpec.feature "Logged in admin can view users loan offer" do
  before(:each) do
    create_user(1,1)
    @admin,@user1,@user2 = create_user(2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)

    @loan_offer = create_loan_offer(1,@user2.id).first
    data = { l_id: @user1.id, b_id: @loan_offer.user.id,
             l_o_id: @loan_offer.id, status: "Pending" }
    @contract = create_contract(1, data)
  end

  scenario "when they visit specified loan offer page from users loan offer index" do
    visit admin_dashboard_path(@admin.username)
    # save_and_open_page
    click_link "View All Contracts"

  #   within(".col-md-2:nth-child(1)") do
  #     expect(page).to have_content(ActionController::Base.helpers.number_to_currency(@loan_offer1.amount))
  #     expect(page).to have_content(@loan_offer1.term)
  #     expect(page).to have_content(@loan_offer1.rate)
  #     expect(page).to have_link("View Details")
  #   end
  #
  #   within(".col-md-2:nth-child(2)") do
  #     expect(page).to have_content(ActionController::Base.helpers.number_to_currency(@loan_offer2.amount))
  #     expect(page).to have_content(@loan_offer2.term)
  #     expect(page).to have_content(@loan_offer2.rate)
  #     expect(page).to have_link("View Details")
  #   end
  #
  #   within(".col-md-2:nth-child(3)") do
  #     expect(page).to have_content(ActionController::Base.helpers.number_to_currency(@loan_offer3.amount))
  #     expect(page).to have_content(@loan_offer3.term)
  #     expect(page).to have_content(@loan_offer3.rate)
  #
  #     click_link "View Details"
  #   end
  #
  #   expect(current_path).to eq(user_loan_offer_path(@user1.username, @loan_offer3.id))
  #   expect(page).to have_content(ActionController::Base.helpers.number_to_currency(@loan_offer3.amount))
  #   expect(page).to have_content(@loan_offer3.term)
  #   expect(page).to have_content(@loan_offer3.rate)
  end
end
