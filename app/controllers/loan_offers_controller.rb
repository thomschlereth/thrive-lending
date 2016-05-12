class LoanOffersController < ApplicationController

  def index
    @loan_offers = LoanOffer.all
  end

  def new
    if current_user && !current_admin?
      @loan_offer = LoanOffer.new
    else
      redirect_to login_path
    end
  end

  def create
    loan_offer = LoanOffer.new(loan_offer_params)
    if current_user.loan_offers << loan_offer
      redirect_to user_loan_offer_path(current_user.username, loan_offer.id)
    else
      flash[:error] = loan_offer.errors.full_messages.join(", ")
      redirect_to new_loan_offer_path
    end
  end

  def edit
    @loan_offer = current_user.loan_offers.find(params[:id])
  end

  def update
    loan_offer = current_user.loan_offers.find(params[:id])
    if loan_offer.update(loan_offer_params)
      redirect_to user_loan_offer_path(current_user.username, loan_offer.id)
    else
      flash[:error] = loan_offer.errors.full_messages.join(", ")
      redirect_to new_loan_offer_path
    end
  end

  def destroy
    if current_user.loan_offers.delete(params[:id])
      redirect_to dashboard_path(current_user.id)
    else

    end
  end

  private

  def loan_offer_params
    params.require(:loan_offer).permit(:rate,
                                        :term,
                                        :amount)
  end
end
