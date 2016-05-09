class OrdersController < ApplicationController
  before_action :require_user
  before_action :set_order, only: [:show]
  before_action :redirect_if_no_order, only: [:show]

  def index
    @user = current_user
    @orders = @user.orders
  end

  def show
    @order_items = OrderItem.where(order_id: @order.id) if @order
  end

  def create
    @order = current_user.orders.new
    if @order.save
      @order.order_confirmed(@cart)
      session.delete :cart
      flash[:notice] = "Order was successfully placed"
      redirect_to orders_path
    else
      flash.now[:error] = "Please log in to place an order"
      redirect_to login_path
    end
  end

  private

  def set_order
    @order = current_user.orders.find_by(id: params[:order_id])
  end

  def redirect_if_no_order
    redirect_to "/errors/not_found.html" unless @order
  end

  def order_params
    params.require(:order).permit(:user_id)
  end
end
