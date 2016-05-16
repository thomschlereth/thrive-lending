require "rails_helper"

RSpec.feature "Logged in admin can view users loan request" do
  before(:each) do
    create_user(1,1)
    @admin,@user1 = create_user(1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)

    @loan_request1, @loan_request2, @loan_request3 = create_loan_request(3,@user1.id)
  end

  scenario "when they visit specified loan request page from users loan request index" do
    visit user_path(@user1.username)
    click_link "View #{@user1.first_name}'s Loan Requests"

    within(".col-md-2:nth-child(1)") do
      expect(page).to have_content(ActionController::Base.helpers.number_to_currency(@loan_request1.amount))
      # expect(page).to have_content(@loan_request1.term)
      expect(page).to have_content(@loan_request1.rate)
      expect(page).to have_link("View Details")
    end

    within(".col-md-2:nth-child(2)") do
      expect(page).to have_content(ActionController::Base.helpers.number_to_currency(@loan_request2.amount))
      # expect(page).to have_content(@loan_request2.term)
      expect(page).to have_content(@loan_request2.rate)
      expect(page).to have_link("View Details")
    end

    within(".col-md-2:nth-child(3)") do
      expect(page).to have_content(ActionController::Base.helpers.number_to_currency(@loan_request3.amount))
      # expect(page).to have_content(@loan_request3.term)
      expect(page).to have_content(@loan_request3.rate)

      click_link "View Details"
    end

    expect(current_path).to eq(user_loan_request_path(@user1.username, @loan_request3.id))
    expect(page).to have_content(ActionController::Base.helpers.number_to_currency(@loan_request3.amount))
    # expect(page).to have_content(@loan_request3.term)
    expect(page).to have_content(@loan_request3.rate)
  end
end
