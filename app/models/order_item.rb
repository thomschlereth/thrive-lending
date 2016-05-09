class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item
  validates :order_id, presence: true
  validates :item_id, presence: true
  validates :quantity, presence: true

  def subtotal
    quantity * item.price
  end
end
