class AddDescriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :description, :string
    add_column :users, :image_path, :string
  end
end
