require "rails_helper"

RSpec.feature "Logged in admin can view user" do
  before(:each) do
    create_user(1,1)
    @admin,@user1,@user2,@user3 = create_user(3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)
  end

  scenario "when they visit specified users page from users index" do
    visit users_path

    click_link(@user1.username)

    expect(current_path).to eq(user_path(@user1.id))
    expect(page).to_not have_link("Create a Loan Request")
    expect(page).to_not have_link("Create a Loan Offer")
    expect(page).to have_link("View #{@user1.first_name}'s Loan Requests")
    expect(page).to have_link("View #{@user1.first_name}'s Loan Offers")
    expect(page).to have_link("Delete #{@user1.first_name}'s Account")
  end
end
