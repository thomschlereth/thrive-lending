require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #new" do

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "redirects to root_url" do
      create_user
      user = User.last
      post :create, email: user.email

      expect(response).to redirect_to root_url
    end

    it "redirects to root_url" do
      nonuser_email = "james@james.james"
      post :create, email: nonuser_email

      expect(response).to redirect_to root_url
      assert_equal 'No user found with that email address.', flash[:warning] 
    end

  end

  describe "GET #edit" do

    it "returns http success with appropriate params" do
      create_user
      user = User.last
      user.update!(password_reset_token: "abc")

      get :edit, {id: "abc"}
      expect(response).to have_http_status(:success)
    end
    
  end

end
