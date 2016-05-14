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
end
