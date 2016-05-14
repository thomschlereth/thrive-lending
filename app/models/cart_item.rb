class CartItem < SimpleDelegator
  attr_reader :item, :quantity

  def initialize(id)
    @item = LoanRequest.find_by(id: id)
    super(@item)
  end

end
