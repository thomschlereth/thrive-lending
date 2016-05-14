class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :loan_requests, :max_int_rate, :rate
    add_column :loan_requests, :term, :integer
  end
end
