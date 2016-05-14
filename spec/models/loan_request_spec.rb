require 'rails_helper'

RSpec.describe LoanRequest, type: :model do
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:rate) }
end
