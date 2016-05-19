class User::ContractPresenter < User::BasePresenter
  include ActionView::Helpers::NumberHelper

  def full_name(side)
    if side == "lender"
      "#{@model.lender.first_name} #{@model.lender.last_name}" if @model.lender
    elsif side == "borrower"
      "#{@model.borrower.first_name} #{@model.borrower.last_name}" if @model.borrower
    end
  end

  def amount(side)
    if side == "request"
      number_to_currency(@model.loan_request.amount) if @model.loan_request
    else
      number_to_currency(@model.loan_offer.amount) if @model.loan_offer
    end
  end

  def admin_amount
    if @model.loan_request
      number_to_currency(@model.loan_request.amount) if @model.loan_request
    elsif @model.loan_offer
      number_to_currency(@model.loan_offer.amount) if @model.loan_offer
    end
  end

  def months(side)
    if side == "request"
      "#{@model.loan_request.term} Months" if @model.loan_request
    else
      "#{@model.loan_offer.term} Months" if @model.loan_offer
    end
  end

  def admin_months
    if @model.loan_request
      "#{@model.loan_request.term} Months" if @model.loan_request
    elsif @model.loan_offer
      "#{@model.loan_offer.term} Months" if @model.loan_offer
    end
  end


  def ir(side)
    if side == "request"
      "#{@model.loan_request.rate}%" if @model.loan_request
    else
      "#{@model.loan_offer.rate}%" if @model.loan_offer
    end
  end

  def admin_ir
    if @model.loan_request
      "#{@model.loan_request.rate}%" if @model.loan_request
    elsif @model.loan_offer
      "#{@model.loan_offer.rate}%" if @model.loan_offer
    end
  end

end
