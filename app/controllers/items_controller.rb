class ItemsController < ApplicationController
  before_action :set_item, except: [:index]
  before_action :redirect_if_no_item, except: [:index]

  def index
    @items = Item.all
    @categories = Category.all
  end

  def show
  end

  private

  def set_item
    @item = Item.find_by(id: params[:id])
  end

  def redirect_if_no_item
    redirect_to "/errors/not_found.html" unless @item
  end
end
