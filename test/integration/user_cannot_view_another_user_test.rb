require "test_helper"

class UserCannotViewAnotherUserTest < ActionDispatch::IntegrationTest
  test "authenticated user cannot view another user" do
    create_user(2)
    user_1 = User.first
    ApplicationController.any_instance.stubs(:current_user).returns(user_1)

    visit "/dashboard/2"
    assert page.has_content? "404"
    visit "/user/2"
    assert page.has_content? "404"
    # I cannot view the administrator screens or use admin functionality
    # I cannot make myself an admin
  end

end
