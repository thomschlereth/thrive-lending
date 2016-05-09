class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def mapped_values
    contents.map do |id, qty|
      CartItem.new(id.to_i, qty)
    end
  end

  def add_item(item_id)
    contents[item_id.to_s] ||= 0
    contents[item_id.to_s] += 1
  end

  def count_all
    contents.values.sum
  end

  def count_of(item_id)
    contents[item_id.to_s]
  end

  def remove_item(item_id)
    contents.delete(item_id)
  end

  def update(item_id, qty)
    contents[item_id.to_s] = qty
  end

  def total_price
    if contents.empty?
      return 0
    else
      mapped_values.map do |ci|
        ci.subtotal
      end.reduce(:+)
    end
  end
end
