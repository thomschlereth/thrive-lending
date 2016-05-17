class Seed

  def initialize
    create_users
    create_loan_offers
    create_loan_requests
  end

  def create_users
    puts "Created Users"
    create_kami_admin
    create_mark_admin
    create_thom
    until User.count == 50 do
      begin
        username = Faker::Name.first_name
        User.create!(first_name: username, last_name: Faker::Name.last_name,
          email: Faker::Internet.email, city: Faker::Address.city, state: Faker::Address.state,
          zipcode: Faker::Address.zip, password: "password",
          address: Faker::Address.street_address, role: 0, username: username.downcase)
      rescue
        username = Faker::Name.first_name
        User.create!(first_name: username, last_name: Faker::Name.last_name,
          email: Faker::Internet.email, city: Faker::Address.city, state: Faker::Address.state,
          zipcode: Faker::Address.zip, password: "password",
          address: Faker::Address.street_address, role: 0, username: username.downcase)
      end
    end
    puts "Created Users"
  end

  def create_loan_offers
    puts "Creating Loan Offers"
    LoanOffer.create(amount: rand(50..10000),
     rate: "#{rand(3..20)}.#{rand(0..99)}".to_f,
     term: rand(3..12),
     user_id: 3)
    until LoanOffer.count == 100 do
      begin
        user = User.find(rand(3..50))
        user.loan_offers.create!(amount: rand(50..10000),
         rate: "#{rand(3..20)}.#{rand(0..99)}".to_f,
         term: rand(3..12))
        create_contract(user.id, loan.id) if (rand(1..10)<5)
      rescue
        user = User.find(rand(3..50))
        user.loan_offers.create!(amount: rand(50..10000),
         rate: "#{rand(3..20)}.#{rand(0..99)}".to_f,
         term: rand(3..12))
      end
    end
    puts "Created Loan Offers"
  end

  def create_loan_requests
    puts "Creating Loan Requests"
    until LoanRequest.count == 150 do
      begin
        user = User.find(rand(3..50))
        loan = user.loan_requests.create!(amount: rand(50..10000),
         rate: "#{rand(3..20)}.#{rand(0..99)}".to_f,
         term: rand(6..72))
        create_contract(user.id, loan.id) if (rand(1..10)<5)
      rescue
        user = User.find(rand(3..50))
        user.loan_requests.create!(amount: rand(50..10000),
         rate: "#{rand(3..20)}.#{rand(0..99)}".to_f,
         term: rand(6..72))
      end
    end
    puts "Created Loan Requests"
  end

  def create_request_contract(user_id, loan_id)
    status = ["Pending", "Approved", "Paid"]
    contract = Contract.create!(lender_id: rand(3..50), borrower_id: user_id, status: status.sample, loan_request_id: loan_id)
  end

  def create_request_contract(user_id, loan_id)
    status = ["Pending", "Approved", "Paid"]
    contract = Contract.create!(borrower_id: rand(3..50), lender_id: user_id, status: status.sample, loan_offer_id: loan_id)
  end


  private

  def create_kami_admin
    User.create!(first_name: "Kami", last_name: "Boers",
      email: "kami@kami.kami", city: "Denver", state: "CO",
      zipcode: "80229", password: "password",
      address: "The Dungeon where there is no sunlight",
      role: 1, username: "kami")
  end

  def create_mark_admin
    User.create!(first_name: "Mark", last_name: "Miranda",
      email: "mark@mark.mark", city: "Denver", state: "CO",
      zipcode: "80229", password: "password",
      address: "The basement flooding from students tears",
      role: 1, username: "mark")
  end

  def create_thom
    User.create!(first_name: "Thom", last_name: "Pickett",
      email: "thom@thom.thom", city: "Denver", state: "CO",
      zipcode: "80229", password: "password",
      address: "The Purgatory of waiting to see if we pass or fail",
      role: 0, username: "thom")
  end
end

Seed.new
