class EditColumnOnLoanOffers < ActiveRecord::Migration
  def change
    change_column :loan_offers, :rate, :float, precision: 4, scale: 2
  end
end
