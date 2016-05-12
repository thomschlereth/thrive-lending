class LoanOffer < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :amount, :rate, :term
end
