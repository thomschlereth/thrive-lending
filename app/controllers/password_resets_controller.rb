class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      redirect_to root_url, success: "Email sent with password reset instructions."
    else
      redirect_to root_url, warning: "No user found with that email address."
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id]) if User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: "Password reset has expired."
    elsif params[:user][:password] != params[:user][:password_confirmation]
      flash[:warning] = "Passwords did not match."
      render :edit
    elsif @user.update!(password: params[:user][:password])
      redirect_to root_url, success: "Password has been reset!"
    else
      flash[:warning] = "An error occurred. Please try again."
      render :edit
    end
  end

end
