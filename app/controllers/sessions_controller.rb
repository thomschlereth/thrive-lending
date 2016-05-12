class SessionsController < ApplicationController

  def new
    set_redirect
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      # session[:user_id] = user.id
      session[:username] = user.username
      if current_admin?
        redirect_to admin_dashboard_path
      else
        redirect_to dashboard_path, success: "yay!"
      end
    else
      flash.now[:danger] = "Invalid Credentials"
      render :new
    end
  end

  def destroy
    session.clear
    @current_user = nil
    redirect_to root_path, success: "info!"
  end
end
