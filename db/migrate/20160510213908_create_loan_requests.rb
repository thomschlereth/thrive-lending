class CreateLoanRequests < ActiveRecord::Migration
  def change
    create_table :loan_requests do |t|
      t.references :user, index: true, foreign_key: true
      t.decimal :amount
      t.decimal :max_int_rate

      t.timestamps null: false
    end
  end
end
