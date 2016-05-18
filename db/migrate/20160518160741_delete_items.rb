class DeleteItems < ActiveRecord::Migration
  def change
    drop_table :items, force: :cascade
  end
end
