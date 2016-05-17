class ContractsController < ApplicationController

  def new
    cart = session[:cart].transform_keys { |k| k.to_sym }
    @loan_requests = cart[:requests].map { |lr| LoanRequest.find(lr) }
    @loan_offers = cart[:offers].map { |lo| LoanOffer.find(lo) }
  end

  def create
    #need to do some major extraction
    cart = session[:cart].transform_keys { |k| k.to_sym }
    loan_requests = LoanRequest.find(cart[:requests])
    loan_offers = LoanOffer.find(cart[:offers])
    loan_requests.each do |lr|
      current_user.lent.create(loan_request_id: lr.id, borrower_id: lr.user_id)
      lr.update(active: false)
    end

    loan_offers.each do |lo|
      current_user.borrowed.create(loan_offer_id: lo.id, lender_id: lo.user_id)
      lo.update(active: false)
    end
    session[:cart]["requests"] = []
    session[:cart]["offers"] = []
    redirect_to user_contracts_path(current_user.username)
  end



end
