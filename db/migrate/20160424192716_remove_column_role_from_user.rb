class RemoveColumnRoleFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :role, :string
    add_column :users, :role, :integer

  end
end
