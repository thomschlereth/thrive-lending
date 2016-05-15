require "rails_helper"

RSpec.feature "User can add loan requests to cart" do

before(:each) do
        create_user(2)
        owner = User.last
        create_loan_request(1, owner.id)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.last)
    end

    scenario "user cannot add their own loan request to their cart" do
        visit loan_requests_path
        click_on "Add To Cart"

        expect(page).to have_content "You cannot accept your own loan."
    end

  end