class UsersController < ApplicationController

  def new
    set_redirect
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:username] = @user.username
      flash[:notice] = "Logged in as #{@user.first_name} #{@user.last_name}"
      redirect_to session[:redirect]
    else
      flash.now[:error] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
    @user = current_user
    @orders = @user.orders
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address, :password, :city, :state, :zipcode, :username)
  end
end
