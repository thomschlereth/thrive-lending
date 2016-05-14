class User::LoanRequestsController < User::BaseController

  def index
    @user = current_user
    @loan_requests = @user.loan_requests
  end

  def show
    @user = User.find_by(username: params[:username])
    @loan_request = @user.loan_requests.find_by(id: params[:id])
  end

  private

  def loan_request_params
    params.require(:loan_request).permit(:amount, :rate)
  end

end
