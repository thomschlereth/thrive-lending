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
      render :new
    end
  end

  def index
    @loan_requests = LoanRequest.all
  end

  def edit
    @loan_request = LoanRequest.find(params[:id])
  end

  def update
    @loan_request = LoanRequest.find(params[:id])

    if @loan_request.update(loan_request_params)
      flash[:success] = "Loan Request Successfully Updated."
      redirect_to user_loan_request_path(current_user.username, @loan_request.id)
    else
      flash[:warning] = "Invalid Loan Request"
      render :edit
    end
  end

  def destroy
    if current_user.loan_requests.delete(params[:id])
      redirect_to user_loan_requests_path(current_user.username), danger: "Loan Request Deleted!"  
    else

    end
  end


    private

  def loan_request_params
    params.require(:loan_request).permit(:amount, :rate, :term)
  end


end
