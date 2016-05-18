class Loan < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :amount, :rate, :term, :user_id, :loan_type

  def offer
    loan_type == "offer"
  end

  def request
    loan_type == "request"
  end


end
