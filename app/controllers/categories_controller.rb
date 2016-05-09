class CategoriesController < ApplicationController
  before_action :set_category
  before_action :redirect_if_no_category

  def show
    @items = @category.items if @category
  end

  private
  
  def set_category
    @category = Category.find_by(name: params[:category])
  end

  def redirect_if_no_category
    redirect_to '/errors/not_found.html' unless @category
  end
end
