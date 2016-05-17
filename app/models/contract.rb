class Contract < ActiveRecord::Base
  belongs_to :lender, class_name: "User"
  belongs_to :borrower, class_name: "User"
  validates :lender_id, presence: true
  validates :borrower_id, presence: true
  belongs_to :loan_request
  belongs_to :loan_offer
end
