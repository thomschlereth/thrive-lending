class ContractsController < ApplicationController

  def new
    @loan_requests = session[:cart].map { |lr| LoanRequest.find(lr) }
  end

  def create
    @loan_requests = session[:cart].map { |lr| LoanRequest.find(lr) }
      @loan_requests.each do |lr|
        current_user.lent.create(loan_request_id: lr.id, borrower_id: lr.user_id)
      end
    redirect_to user_contracts_path(current_user.username)
  end



end