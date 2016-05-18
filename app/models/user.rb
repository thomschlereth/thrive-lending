class User < ActiveRecord::Base
  has_secure_password
  has_many :loan_offers
  has_many :orders
  has_many :loan_requests
  has_many :lent, class_name: "Contract",
                  foreign_key: "lender_id"
  has_many :borrowed, class_name: "Contract",
                                  foreign_key: "borrower_id"
  has_many :borrowers, through: :lent, source: :borrower
  has_many :lenders, through: :borrowed, source: :lender

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :first_name,     presence: true
  validates :last_name,      presence: true
  validates :email,          presence: true, uniqueness: true
  validates :email,          format: { with: VALID_EMAIL_REGEX }
  validates :address,           presence: true
  validates :city,           presence: true
  validates :state,          presence: true
  validates :username,       presence: true, uniqueness: true
  validates :zipcode,        presence: true,
                             length: { minimum: 5 }

  enum role: ["default", "admin"]

  def loans_count(side)
    active_loans(side).size
  end

  def approved_loans_count(side)
    active_approved_loans(side).size
  end

  def investment(side)
    a = active_approved_loans(side).pluck(:amount).sum
    b = active_loans(side).pluck(:amount).sum
    a + b
  end

  def net_worth
    investment("offers") - investment("requests")
  end

  private

  def active_loans(side)
    if side == "offers"
      loan_offers.where(active: true)
    elsif side == "requests"
      loan_requests.where(active: true)
    else
      []
    end
  end

  def active_approved_loans(side)
    if side == "offers"
      lent.where(active: true).joins(:loan_offer)
    elsif side == "requests"
      borrowed.where(active: true).joins(:loan_request)
    else
      []
    end
  end

end
