class User::BaseController < ApplicationController


  def require_user
    redirect_to "/errors/not_found.html" unless current_user
  end

end
