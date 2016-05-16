require "rails_helper"

RSpec.feature "Logged in admin can view users" do
  before(:each) do
    create_user(1,1)
    @admin,@user1,@user2,@user3 = create_user(3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)
  end

  scenario "when they visit users page" do
    visit "/admin/dashboard"
    click_link "View All Users"

    expect(page).to have_link(@user1.username)
    expect(page).to have_link(@user2.username)
    expect(page).to have_link(@user3.username)
  end
end
