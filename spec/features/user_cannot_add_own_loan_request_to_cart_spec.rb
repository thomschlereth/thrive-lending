require "rails_helper"

RSpec.feature "User can add loan requests to cart" do

before(:each) do
        create_user(2)
        owner = User.last
        create_loan_request(1, owner.id)
        ApplicationController.any_instance.stub(:current_user).and_return(User.last)
    end

    scenario "user cannot add their own loan request to their cart" do
        visit loan_requests_path
        click_on "Add to Cart"

        expect(page).to have_content "You cannot accept your own loan."
    end

  end