require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:zipcode) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_length_of(:zipcode).is_at_least(5) }

  it "can return a lenders contracts" do
    user1, user2 = create_user(2)
    contract_hash = {l_id: user1.id, b_id: user2.id}
    create_contract(1, contract_hash)

    expect(user1.lent.size).to eq(1)
    expect(user2.lent.size).to eq(0)
  end

  it "can return a borrowers contracts" do
    user1, user2 = create_user(2)
    contract_hash = {l_id: user1.id, b_id: user2.id}
    create_contract(1, contract_hash)

    expect(user2.borrowed.size).to eq(1)
    expect(user1.borrowed.size).to eq(0)
  end

  it "can find a lender/borrower relationship" do
    user1, user2 = create_user(2)
    contract_hash = {l_id: user1.id, b_id: user2.id}
    create_contract(1, contract_hash)

    expect(user1.borrowers).to eq [user2]
    expect(user2.lenders).to eq [user1]
  end

  it "can find active loan offers" do
    create_user(1)
    user = User.first
    create_loan_offer(1, user.id)

    expect(user.loans_count("offers")).to eq 1
    create_loan_offer(2, user.id)
    expect(user.loans_count("offers")).to eq 3
    LoanOffer.last.update(active: false)
    expect(user.loans_count("offers")).to eq 2
  end

  it "can find active contracts" do
    user1, user2 = create_user(2)
    create_loan_offer(1, user1.id)
    offer = LoanOffer.first
    c_hash = {l_id: user1.id, b_id: user2.id, l_o_id: offer.id, }
    create_contract(1, c_hash)
    expect(user1.approved_loans_count("offers")).to eq 1
    expect(user2.approved_loans_count("offers")).to eq 0
  end

  it "can find offer investment amount" do
    user1, user2 = create_user(2)
    offers = create_loan_offer(2, user1.id)
    offers.each do |o|
      c_hash = {l_id: user1.id, b_id: user2.id, l_o_id: o.id, }
      o.update(active: false)
      create_contract(1, c_hash)
    end
    c1 = Contract.first.loan_offer.amount
    c2 = Contract.last.loan_offer.amount
    expected = c1 + c2
    expect(user1.investment("offers")).to eq expected
  end

  it "can find portfolio net worth" do
    user1, user2 = create_user(2)
    offers = create_loan_offer(2, user1.id)
    requests = create_loan_request(3, user1.id)
    offers.each do |o|
      c_hash = {l_id: user1.id, b_id: user2.id, l_o_id: o.id, }
      o.update(active: false)
      create_contract(1, c_hash)
    end

    requests.each do |r|
      c_hash = {b_id: user1.id, l_id: user2.id, l_o_id: r.id, }
      r.update(active: false)
      create_contract(1, c_hash)
    end

    expected = user1.investment("offers") - user1.investment("requests")
    expect(user1.net_worth).to eq expected
  end

end
