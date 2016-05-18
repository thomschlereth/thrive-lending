require "rails_helper"

RSpec.feature "Logged in user can delete profile" do
  before(:each) do
    @user1, @user2 = create_user(2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)
  end

  scenario "when they visit dashboard and click delete" do
    visit dashboard_path

    expect(User.where(active: true).count).to eq(2)

    click_button "Deactivate Account"

    expect(current_path).to eq(root_path)
    expect(User.where(active: true).count).to eq(1)
    expect(User.where(active: false).count).to eq(1)
  end

end
