class User < ActiveRecord::Base
  has_secure_password
  has_many :orders

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :first_name,     presence: true
  validates :last_name,      presence: true
  validates :email,          presence: true, uniqueness: true
  validates :email,          format: { with: VALID_EMAIL_REGEX }
  validates :city,           presence: true
  validates :state,          presence: true
  validates :zipcode,        presence: true,
                             length: { minimum: 5 }

  enum role: ["default", "admin"]
end
