require 'rails_helper'

RSpec.describe LoanHelper, type: :helper do

  it "can calculate monthly payments" do
    loan = LoanOffer.create(rate: 12.33, term: 12, amount: 1000)
    expect(helper.monthly_payment(loan)).to eq 89.00
  end

  it "can calculate total interest only" do
    loan = LoanOffer.create(rate: 12.33, term: 12, amount: 1000)
    expect(helper.interest(loan)).to eq 68.00
  end

  it "can calculate total_payments" do
    loan = LoanOffer.create(rate: 12.33, term: 12, amount: 1000)
    expect(helper.total_payments(loan)).to eq 1068.00
  end

  it "can calculate effective interest rate" do
    loan = LoanOffer.create(rate: 12.33, term: 12, amount: 1000)
    expect(helper.effective_interest(loan)).to eq 6.80
  end
end
