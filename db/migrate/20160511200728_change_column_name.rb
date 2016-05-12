class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :loan_requests, :loan_amount, :amount
  end
end
