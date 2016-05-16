class CartItem < SimpleDelegator
  attr_reader :item, :quantity

  def initialize(id, obj)
    @item = obj.find_by(id: id)
    super(@item)
  end

end
