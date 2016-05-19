class UsersController < ApplicationController
  before_action :require_admin, only: [:index]

  def new
    set_redirect
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      cookies[:auth_token] = @user.auth_token
      flash[:notice] = "Logged in as #{@user.first_name} #{@user.last_name}"
      redirect_to dashboard_path
      UserNotifier.welcome(@user, @user.email).deliver_now
    else
      flash.now[:danger] = @user.errors.full_messages.join(", ")
      redirect_to session[:redirect]
      render :new
    end
  end

  def show
    if current_admin?
      @user = User.find_by(username: params[:username])
    else
      render :dashboard
    end
  end

  def index
    @active_users = User.where(active: true)
    @inactive_users = User.where(active: false)
  end

  def destroy
    if current_user && !current_admin?
      current_user.loan_requests.update_all(active: false)
      current_user.loan_offers.update_all(active: false)
      current_user.active_update
      UserNotifier.unwelcome(current_user, current_user.email).deliver_now
      redirect_to logout_path
    elsif current_admin?
      user = User.find(params[:id])
      user.loan_requests.update_all(active: false)
      user.loan_offers.update_all(active: false)
      user.active_update
      UserNotifier.unwelcome(user, user.email).deliver_now
      redirect_to users_path, success: "deactivated!"

    else
      flash[:danger] = "You don't have permission"
      redirect_to "/"
    end
  end

  def dashboard
    if current_user
      redirect_to admin_dashboard_path if current_admin?
      @user = current_user
    else
      redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address, :password, :city, :state, :zipcode, :username)
  end
end
