class User::LoanOffersController < User::BaseController

  def index
    #Should admin only be able to see these.
    #Should and should we scope them to active for
    #regular users and and all to admin
    @user = User.find_by(username: params[:username])
    @loan_offers = @user.loan_offers
  end

  def show
    #Should admin only be able to see these.
    #Should and should we scope them to active for
    #regular users and and all to admin
    @user = User.find_by(username: params[:username])
    @loan_offer = @user.loan_offers.find_by(id: params[:id])
  end

end
