class AddAttachmentAvatarToDietitians < ActiveRecord::Migration
  def self.up
    change_table :dietitians do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :dietitians, :avatar
  end
end
