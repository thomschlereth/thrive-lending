class User::LoanOffersController < User::BaseController

  def index
    @user = User.find_by(username: params[:username])
    @loan_offers = @user.loan_offers
    
  end

  def show
    @user = User.find_by(username: params[:username])
    @loan_offer = @user.loan_offers.find_by(id: params[:id])

  end

end
