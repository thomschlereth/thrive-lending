class LoanRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :contract
  validates_presence_of :amount, :rate, :term
end
