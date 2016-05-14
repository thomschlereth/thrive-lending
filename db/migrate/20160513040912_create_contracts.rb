class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :lender_id
      t.integer :borrower_id
      t.references :loan_request
      t.references :loan_offer
      t.boolean :approved
      t.timestamps null: false
    end

    add_index :contracts, :lender_id
    add_index :contracts, :borrower_id
    add_index :contracts, [:lender_id, :borrower_id]
  end
end
