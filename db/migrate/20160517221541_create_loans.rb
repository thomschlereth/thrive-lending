class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.float :rate
      t.integer :term
      t.integer :amount
      t.boolean :active, default: true
      t.references :user, index: true, foreign_key: true
      t.string :loan_type
    end
  end
end
