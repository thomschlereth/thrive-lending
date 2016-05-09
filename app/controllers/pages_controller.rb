class PagesController < ApplicationController

  def splash
    @disable_nav = true
    @sample = Page.get_popular_products
  end
end
