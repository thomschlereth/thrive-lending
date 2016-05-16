require "rails_helper"

RSpec.feature "Logged in admin sees dashboard" do
  before(:each) do
    create_user(1,1)
    admin = User.last
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)
  end

  scenario "when they click on dashboard" do
    visit "/"
    click_link "Dashboard"

    expect(current_path).to eq(admin_dashboard_path)
  end
end
