require 'rails_helper'

describe UsersController, type: :controller do
  describe "GET #new" do
    it "returns http success" do
      get :new
      
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #new" do
    it "returns http success" do
      post :new

      expect(response).to have_http_status(:success)
    end

    it "should create one user" do
      expect(User.count).to eq(0)
      post :create, user: {first_name: "Steve", last_name: "McSteve", description: "Stevey",
        email: "Steve@steve.steve", city: "Stevetown", state: "ST",
        zipcode: "80800", password: "password", image_path: "photo_url",
        address: "street_address", role: 0, username: "username"}

        assert_equal 'Logged in as Steve McSteve', flash[:notice]
        expect(User.count).to eq(1)
    end

    it "redirects to the user dashboard path" do
       post :create, user: {first_name: "Steve", last_name: "McSteve", description: "Stevey",
        email: "Steve@steve.steve", city: "Stevetown", state: "ST",
        zipcode: "80800", password: "password", image_path: "photo_url",
        address: "street_address", role: 0, username: "username"}

        assert_redirected_to dashboard_path
    end

     it "should fails to create a user with inadequate params" do
      expect(User.count).to eq(0)
      post :create, user: {first_name: "Steve", last_name: "McSteve", description: "Stevey",
        email: "Steve@steve.steve"}

        expect(User.count).to eq(0)
        expect(response).to render_template :new
    end

  end
end


