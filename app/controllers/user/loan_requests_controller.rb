class User::LoanRequestsController < User::BaseController

  def index
    @user = User.find_by(username: params[:username])
    @loan_requests = @user.loan_requests
  end

  def show
    @user = User.find_by(username: params[:username])
    @loan_request = @user.loan_requests.find_by(id: params[:id])
  end

end
