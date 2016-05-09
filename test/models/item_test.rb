require "test_helper"

class ItemTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_presence_of(:description)
  should validate_numericality_of(:price)
end
