class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
  validates :user_id, presence: true

  def self.format_time(time)
    time.strftime("%A, %b %d, %Y")
  end

  def update_time
    updated_at.strftime("%A, %b %d, %Y")
  end

  def total_price
    order_items.map{ |oi| oi.subtotal }.sum
  end

  def order_confirmed(cart)
    cart.contents.each_pair do |id, qty|
      order_items.create(item_id: id, quantity: qty)
      update(status: "ordered")
    end
  end
end
