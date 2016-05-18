class User::ContractsController < User::BaseController

  def index
    @user = User.find_by(username: params[:current_username])
    if current_user == @user
      @l_contracts = current_user.lent.where(active: true)
      @b_contracts = current_user.borrowed.where(active: true)
    elsif current_admin?
      @l_contracts = @user.lent
      @b_contracts = @user.borrowed
    else
      render file: '/public/404'
    end
  end

end
