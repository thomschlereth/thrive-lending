class CartAddManager
  attr_reader :message, :valid

  def self.call(referrer, id, cart, user)
    @user = user
    cart.transform_keys! { |k| k.to_sym }
    referrer.include?('offers') ? add_item(id, LoanOffer, cart[:offers]) : add_item(id, LoanRequest, cart[:requests])
  end

  def self.add_item(id, obj, cart)
    item = obj.find(id)
    valid, message = verify_addition(item, cart)
    return [item.id, obj, valid, message]
  end

  def self.verify_addition(item, cart_contents)
    if cart_contents.include?(item.id.to_s)
      [false, "Loan is already in cart."]
    elsif item.user == @user
      [false, "You cannot accept your own loan."]
    else
      [true, "Loan saved to cart."]
    end
  end

end