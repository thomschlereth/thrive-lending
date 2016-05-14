class CartItemsController < ApplicationController

  def create
    set_redirect
    item = LoanRequest.find(params[:item_id])
    if @cart.contents.include?(item.id.to_s)
      flash[:warning] = "Loan is already in cart."
    elsif item.user == current_user
      flash[:warning] = "You cannot accept your own loan."
    else
      @cart.add_item(item.id)
      flash[:notice] = "Loan saved to cart."
      session[:cart] = @cart.contents
    end
      redirect_to session[:redirect]
  end

  def index
    @items = @cart.mapped_values || []
  end

  def destroy
    item = LoanRequest.find(params[:id])
    @cart.remove_item(params[:id])
    flash[:notice] = "Successfully removed <a href=\"/#{item.user.username}/loan_requests/#{item.id}\"> loan</a>!"
    redirect_to cart_path
  end
end
