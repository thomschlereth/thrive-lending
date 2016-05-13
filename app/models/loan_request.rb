class LoanRequest < ActiveRecord::Base
  belongs_to :user

    validates_presence_of :amount, :max_int_rate
end
