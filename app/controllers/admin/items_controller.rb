class Admin::ItemsController < Admin::BaseController

  def index
    @items = Item.all
  end

  def show
    @item = Item.find_by(id: params[:id])
    redirect_to '/errors/not_found.html' unless @item
  end

  def new
    @categories = Category.all
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)

    if @item.save
      flash[:notice] = "Successfully created a new item"
      redirect_to admin_items_path
    else
      flash.now[:error] = @item.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      flash[:notice] = "Item has been updated"
      redirect_to admin_items_path
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :retired, :avatar)
  end
end
