class CartItem < SimpleDelegator
  attr_reader :item, :quantity

  def initialize(id, qty)
    @item = Item.find_by(id: id)
    @quantity = qty
    super(@item)
  end

  def subtotal
    item.price * quantity
  end
end
