require "rails_helper"

RSpec.describe Cart, type: :model do

  it "instantiates with arguments as contents" do
    cart = Cart.new(["4", "23"])

    assert_equal ["4", "23"], cart.contents
  end 

  it "counts all items in the cart" do
    cart = Cart.new(%w(1 2 3))

    assert_equal 3, cart.count_all
  end

  it "adds an item to the cart" do
    cart = Cart.new([])
    cart.add_item(1)
    assert_equal (["1"]), cart.contents
  end

  it "removes an item from the cart" do
    cart = Cart.new(%w(1 2 3))
    
    assert_equal 3, cart.count_all

    cart.remove_item("1")
    assert_equal 2, cart.count_all
    refute cart.contents.include?("1")
  end

  it "calculates the total cost of all items" do
    create_loan_request(2)
    item1 = LoanRequest.first
    item2 = LoanRequest.last
    cart = Cart.new([item1.id, item2.id])
    expected = (item1.amount + item2.amount)

    assert_equal expected, cart.total_price
  end

end