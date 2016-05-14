class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || []
  end

  def mapped_values
    contents.map do |id|
      CartItem.new(id.to_i)
    end
  end

  def add_item(item_id)
    contents << item_id.to_s
  end

  def count_all
    contents.count
  end

  def remove_item(item_id)
    contents.delete(item_id)
  end

  def total_price
    if contents.empty?
      return 0
    else
      mapped_values.map do |ci|
        ci.amount
      end.reduce(:+)
    end
  end
end
