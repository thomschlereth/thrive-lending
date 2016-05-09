require "test_helper"

class PageTest < ActiveSupport::TestCase
  def test_3_popular_products
    create_categories
    create_items(4)

    assert_equal 3, Page.get_popular_products.size
  end
end
