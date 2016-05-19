class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {requests: [], offers: []}
  end

  def mapped_values
    contents.transform_keys! { |k| k.to_sym }
    requests = contents[:requests].map do |id|
      CartItem.new(id.to_i, LoanRequest)
    end
    offers = contents[:offers].map do |id|
      CartItem.new(id.to_i, LoanOffer)
    end
    [requests, offers]
  end

  def add_item(item_id, obj)
    obj == LoanOffer ? contents[:offers] << item_id.to_s : contents[:requests] << item_id.to_s
  end

  def requests_count
    contents[:requests].count
  end

  def offers_count
    contents[:offers].count
  end

  def count_all
    requests_count + offers_count
  end

  def remove_item(item_id, obj)
    contents.transform_keys! { |k| k.to_sym }
    obj == LoanOffer ? contents[:offers].delete(item_id) : contents[:requests].delete(item_id)
  end

  def req_price
    mapped_values[0].map do |ci|
        ci.amount
      end.reduce(:+).to_f
  end

  def off_price
    mapped_values[1].map do |ci|
        ci.amount
      end.reduce(:+).to_f
  end

end
