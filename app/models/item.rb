class Item < ActiveRecord::Base
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items
  has_attached_file :avatar,
                    styles: {thumb: '100x100>',
                             square: '200x200#',
                             medium: '300x300>'},
                    default_url: "default.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :name, uniqueness: true, presence: true
  validates :description, presence: true
  validates_numericality_of :price,  greater_than: 0


  def disabled_item?
    retired ? ["Item Retired", disabled: true] : ["Add to Cart", disabled: false]
  end
end
