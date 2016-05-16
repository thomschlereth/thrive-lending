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
    if current_admin?
      @user = User.find(params[:id])
      @orders = @user.orders
    else
      render :dashboard
    end
  end

  def index
    @users = User.where(role: 0)
  end

  def destroy
    if current_user && !current_admin?
      current_user.destroy
      redirect_to new_user_path
    elsif current_admin?
      User.find(params[:id]).destroy
      redirect_to users_path
    else
      flash[:message] = "You don't have permission"
      redirect_to "/"
    end
  end

  def dashboard
    if current_user
      redirect_to admin_dashboard_path if current_admin?
      @user = current_user
      @orders = @user.orders
    else
      redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address, :password, :city, :state, :zipcode, :username)
  end
end
