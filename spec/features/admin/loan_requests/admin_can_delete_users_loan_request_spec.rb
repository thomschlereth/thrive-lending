require "rails_helper"

RSpec.feature "Logged in admin can delete users loan request" do
  before(:each) do
    create_user(1,1)
    @admin,@user1 = create_user(1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)

    @loan_request1,@loan_request2,@loan_request3  = create_loan_request(3,@user1.id)
  end

  scenario "when they click delete button on loan request page" do
    expect(@user1.loan_requests.count).to eq(3)
    visit user_loan_request_path(@user1.username, @loan_request1.id)

    click_button "Delete request"

    expect(current_path).to eq(user_path(@user1.username))
    expect(@user1.loan_requests.count).to eq(2)
  end
end
