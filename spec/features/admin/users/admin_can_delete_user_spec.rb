require "rails_helper"

RSpec.feature "Logged in admin can delete user" do
  before(:each) do
    create_user(1,1)
    @admin,@user1,@user2,@user3 = create_user(3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)
  end

  scenario "when they visit users page and click delete" do
    visit user_path(@user1.username) 

    expect(User.where(active: true).count).to eq(4)

    click_link "Delete #{@user1.first_name}'s Account"

    expect(current_path).to eq(users_path)
    expect(page).to_not have_link(@user1.username)
    expect(User.where(active: true).count).to eq(3)
    expect(User.where(active: false).count).to eq(1)
  end

end
