class AddAttachmentAvatarToRecipes < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :recipes, :avatar
  end
end
