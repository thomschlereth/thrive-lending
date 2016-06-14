require 'simplecov'
SimpleCov.start

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  def create_categories(num = 1)
    num.times do
      Category.create(name: Faker::Commerce.department(1))
    end
  end

  def create_orders(num = 1, user_id = nil, status = nil)
    @statuses = ["ordered", "paid", "completed", "cancelled"]
    num.times do
      Order.create(
      user_id: user_id || User.all.sample.id,
      status: status || @statuses.sample
      )
    end
  end

  def create_user(num = 1, role = 0)
    num.times do
      first_name = Faker::Name.first_name
      User.create(first_name: first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.safe_email,
      address: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zipcode: Faker::Address.zip_code,
      image_path: "yo!",
      description: Faker::Commerce.department,
      password: "password",
      username: first_name.downcase,
      role: role)
    end
    User.all
  end

  def create_loan_request(num=1, user_id=nil)
    num.times do
      LoanRequest.create(amount: rand(100..10000), rate: rand(1.0..20.0), term: rand(6..72), user_id: user_id)
    end
    LoanRequest.all
  end

    def create_loan_offer(num=1, user_id=nil)
    num.times do
      LoanOffer.create(amount: rand(100..10000), rate: rand(1.0..20.0), term: rand(1...240), user_id: user_id)
    end
    LoanOffer.all
  end

  def create_contract(num = 1, data)
    num.times do
      Contract.create(lender_id: data[:l_id], borrower_id: data[:b_id], loan_request_id: data[:l_r_id], loan_offer_id: data[:l_o_id], status: data[:status])
    end
    Contract.all
  end

end
