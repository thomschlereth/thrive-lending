module LoanHelper

  def monthly_payment(loan)
    rate = (loan.rate/100)
    top = ((loan.rate/100/12)*loan.amount)
    bottom = (1 - (1 + (rate/12)) ** (loan.term * -1))
    format_amount(top/bottom)
  end

  def total_payments(loan)
    format_amount(monthly_payment(loan) * loan.term)
  end

  def interest(loan)
    format_amount(total_payments(loan) - loan.amount)
  end

  def effective_interest(loan)
    format_amount(interest(loan)/loan.amount * 100)
  end

  private

    def format_amount(amount)
      (amount * 100).round.to_f / 100
    end

end
