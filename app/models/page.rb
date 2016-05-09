class Page
  def self.get_popular_products
    Item.all.sample(3)
  end
end
