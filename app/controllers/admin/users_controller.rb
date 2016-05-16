class Admin::UsersController < Admin::BaseController

  def show
    @user = User.find(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address, :password, :city, :state, :zipcode)
  end
end
