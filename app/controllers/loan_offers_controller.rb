class LoanOffersController < ApplicationController

  def index
    @loan_offers = LoanOffer.where(active: true)
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
      redirect_to user_loan_offer_path(current_user.username, loan_offer.id), success: "yay!"
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
    if current_user && !current_admin?
      current_user.loan_offers.delete(params[:id])
      redirect_to user_loan_offers_path(current_user.username), danger: "Loan Offer Deleted!"
    elsif current_admin?
      loan_offer = LoanOffer.find(params[:id])
      user = loan_offer.user
      loan_offer.destroy
      redirect_to user_path(user.username)
    else
      redirect_to "/", danger: "Access Denied"
    end
  end

  private

  def loan_offer_params
    params.require(:loan_offer).permit(:rate,
                                        :term,
                                        :amount)
  end
end
