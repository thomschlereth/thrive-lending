require 'test_helper'

class UserSeesAHomepageTest < ActionDispatch::IntegrationTest
  test "user visits the root and sees a home page" do
    visit root_path

    assert page.has_content? "NACHOMOMS PALEO"
    assert page.has_link? "Shop"
  end
end
