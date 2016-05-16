class AddSttus < ActiveRecord::Migration
  def change
    add_column :contracts, :active, :boolean, default: true
    add_column :users, :active, :boolean, default: true
    add_column :loan_offers, :active, :boolean, default: true
    add_column :loan_requests, :active, :boolean, default: true
  end
end
