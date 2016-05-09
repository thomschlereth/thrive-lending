class Admin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    redirect_to "/errors/not_found.html" unless current_admin?
  end
end
