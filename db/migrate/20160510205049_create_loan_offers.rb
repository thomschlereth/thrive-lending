class CreateLoanOffers < ActiveRecord::Migration
  def change
    create_table :loan_offers do |t|
      t.integer :rate
      t.integer :term
      t.integer :amount
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
