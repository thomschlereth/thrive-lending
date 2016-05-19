class SessionsController < ApplicationController

  def new
    set_redirect
    redirect_to dashboard_path(current_user.id) if current_user
  end

  def create
    set_redirect
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      if params[:remember_me]
      cookies.permanent![:auth_token] = user.auth_token
    else
      cookies[:auth_token] = user.auth_token
    end

      if current_admin?
        redirect_to admin_dashboard_path
      elsif !user.active
        session.clear
        cookies.delete(:auth_token)
        redirect_to root_path, danger: "Account is inactive, please contact us for help"
      else
        redirect_to dashboard_path, success: "yay!"
      end
    else
      flash.now[:danger] = "Invalid Credentials"
      render :new
    end
  end

  def destroy
    cookies.delete(:auth_token)
    session.clear
    @current_user = nil
    redirect_to root_path, success: "logged out!"
  end
end
