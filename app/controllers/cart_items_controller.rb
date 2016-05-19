class CartItemsController < ApplicationController

  def create
    set_redirect
    id, obj, valid, message = CartAddManager.call(request.referrer, params[:item_id], @cart.contents, current_user)
    if !valid
      flash[:warning] = message
    else
      @cart.add_item(id, obj)
      session[:cart] = @cart.contents
      flash[:success] = message
    end
    redirect_to session[:redirect]
  end

  def index
    @items = @cart.mapped_values || [[],[]]
  end

  def destroy
    params[:item_class] == "request" ? item = LoanRequest.find(params[:id]) : item = LoanOffer.find(params[:id])
    @cart.remove_item(params[:id], item.class)
    flash[:notice] = "Successfully removed <a href=\"/#{item.user.username}/loan_requests/#{item.id}\"> loan</a>!"
    redirect_to cart_path
  end
end
