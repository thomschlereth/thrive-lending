require 'rails_helper'

RSpec.describe Contract, type: :model do
  it { should validate_presence_of(:lender_id)}
  it { should validate_presence_of(:borrower_id)}
end
