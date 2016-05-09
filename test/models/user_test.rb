require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:email)
  should validate_presence_of(:zipcode)
  should validate_presence_of(:city)
  should validate_presence_of(:state)
  should validate_length_of(:zipcode).is_at_least(5)
end
