class SessionCreator

def self.call(user_id)
  user = User.find(user_id, user_authenticated)
   if user_id && user_authenticated
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