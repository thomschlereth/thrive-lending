 class LoanRequestsController < User::BaseController

 def new
    @loan_request = LoanRequest.new
  end

  def create
    @loan_request = LoanRequest.new(loan_request_params)
    @loan_request.user_id = current_user.id
    if @loan_request.save
      redirect_to user_loan_request_path(id: @loan_request.id, username: current_user.username)
    else
      flash[:now] = "Invalid Loan Request"
    end
  end

  def index
    @loan_requests = LoanRequest.all
  end
    private

  def loan_request_params
    params.require(:loan_request).permit(:amount, :max_int_rate)
  end


end