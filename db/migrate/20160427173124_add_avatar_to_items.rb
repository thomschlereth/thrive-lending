class AddAvatarToItems < ActiveRecord::Migration
  def self.up
    add_attachment :items, :avatar
  end

  def self.down
    remove_attachement :friends, :avatar
  end
end
