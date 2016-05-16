require "rails_helper"

RSpec.describe Cart, type: :model do

  it "instantiates with arguments as contents" do
    cart = Cart.new({requests: ["4"], offers: ["23"]})

    assert_equal({:requests=>["4"], :offers=>["23"]}, cart.contents)
  end 

  it "counts all items in the cart" do
    cart = Cart.new({offers: ["1", "2"], requests: ["3"]})

    assert_equal 2, cart.offers_count
    assert_equal 1, cart.requests_count
  end

  it "adds an item to the cart" do
    cart = Cart.new(nil)
    cart.add_item(1, LoanOffer)

    assert_equal (["1"]), cart.contents[:offers]
  end

  it "adds items to the right section of contents" do
    cart = Cart.new(nil)
    cart.add_item(1, LoanRequest)

    assert_equal 1, cart.requests_count
    assert_equal 0, cart.offers_count
  end

  it "removes an item from the cart" do
    cart = Cart.new({offers: ["1", "2"], requests: ["3"]})
    
    assert_equal 3, cart.count_all

    cart.remove_item("1", LoanOffer)
    assert_equal 2, cart.count_all
    refute cart.contents[:offers].include?("1")
  end

  it "calculates the total cost of all requests" do
    create_loan_request(2)
    item1 = LoanRequest.first
    item2 = LoanRequest.last

    cart = Cart.new({requests: [item1.id, item2.id], offers: []})
    expected = (item1.amount + item2.amount)

    assert_equal expected, cart.req_price
  end

end