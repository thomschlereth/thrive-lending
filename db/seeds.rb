class Seed

  def initialize
    create_users
    create_loan_offers
    create_loan_requests
  end

  def create_users
    puts "Creating Users"
    create_andrew_admin
    puts "Created Admin"
    create_josh
    puts "Created Standard Default User"
    until User.count == 100 do
      begin
        User.create!(first_name: username, last_name: Faker::Name.last_name, description: Faker::Commerce.department,
          email: Faker::Internet.email, city: Faker::Address.city, state: Faker::Address.state,
          zipcode: Faker::Address.zip, password: "password", image_path: photo_url,
          address: Faker::Address.street_address, role: 0, username: username.downcase)
      rescue
        puts "Rescue User"
        User.create!(first_name: username, last_name: Faker::Name.last_name, description: Faker::Commerce.department,
          email: Faker::Internet.email, city: Faker::Address.city, state: Faker::Address.state,
          zipcode: Faker::Address.zip, password: "password", image_path: photo_url,
          address: Faker::Address.street_address, role: 0, username: username.downcase)
        puts "User Rescued"
      end
    end
    puts "Created Random Standard Users"
  end

  def create_loan_offers
    puts "Creating Loan Offers"
    until LoanOffer.count == 50 do
      begin
        user = User.find(rand(3..50))
        loan = user.loan_offers.create!(amount: rand(50..10000),
         rate: "#{rand(3..20)}.#{rand(0..99)}".to_f,
         term: rand(3..12))
        create_offer_contract(user.id, loan.id) if (rand(1..10)<5)
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
    until LoanRequest.count == 50 do
      begin
        user = User.find(rand(3..50))
        loan = user.loan_requests.create!(amount: rand(50..10000),
         rate: "#{rand(3..20)}.#{rand(0..99)}".to_f,
         term: rand(6..72))
        create_request_contract(user.id, loan.id) if (rand(1..10)<5)
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
    contract.loan_request.update(active: false)
  end

  def create_offer_contract(user_id, loan_id)
    status = ["Pending", "Approved", "Paid"]
    contract = Contract.create!(borrower_id: rand(3..50), lender_id: user_id, status: status.sample, loan_offer_id: loan_id)
    contract.loan_offer.update(active: false)
  end


  private

  def create_andrew_admin
    User.create!(first_name: "Andrew", last_name: "Carmer", image_path: photo_url,
      email: "Andrew@andrew.andrew", city: "Denver", state: "CO",
      zipcode: "80229", password: "password", description: Faker::Commerce.department,
      address: "The basement flooding from students tears",
      role: 1, username: "andrew")
  end

  def create_josh
    User.create!(first_name: "Josh", last_name: "Mejia", image_path: photo_url,
      email: "josh@josh.josh", city: "Denver", state: "CO",
      zipcode: "80229", password: "password", description: Faker::Commerce.department,
      address: "The Purgatory that is this project waiting to see if we pass or fail",
      role: 0, username: "josh")
  end

  def username
    username = Faker::Name.first_name
  end

  def photo_url
    fetcher = Fotofetch::Fetch.new
    photo_url = fetcher.fetch_links("SEARCHTERM").values.first
  end

end

Seed.new
