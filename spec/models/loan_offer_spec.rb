require 'rails_helper'

RSpec.describe LoanOffer, type: :model do
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:rate) }
  it { should validate_presence_of(:term) }
end
