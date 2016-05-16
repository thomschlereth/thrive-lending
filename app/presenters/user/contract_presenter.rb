class User::ContractPresenter < User::BasePresenter
  include ActionView::Helpers::NumberHelper

  def full_name(side)
    if side == "lender"
      "#{@model.lender.first_name} #{@model.lender.last_name}"
    else
      "#{@model.borrower.first_name} #{@model.borrower.last_name}"
    end
  end

  def amount(side)
    if side == "request"
      number_to_currency(@model.loan_request.amount)
    else
      number_to_currency(@model.loan_offer.amount)
    end
  end

  def months(side)
    if side == "request"
      "#{@model.loan_request.term} Months"
    else
      "#{@model.loan_offer.term} Months"
    end
  end

  def ir(side)
    if side == "request"
      "#{@model.loan_request.rate}%"
    else
      "#{@model.loan_offer.rate}%"
    end
  end


end
