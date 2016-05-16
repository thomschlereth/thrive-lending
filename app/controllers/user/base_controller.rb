class User::BaseController < ApplicationController

  # before_action :require_user

  def require_user
    redirect_to "/errors/not_found.html" unless current_user
  end

end
