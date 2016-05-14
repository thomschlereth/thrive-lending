class RenameColumnOnContracts < ActiveRecord::Migration
  def change
    rename_column :contracts, :approved, :status
    change_column :contracts, :status, :string, default: "Pending" 
  end
end
