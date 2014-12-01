class AddFamilyNoteToUser < ActiveRecord::Migration
  def change
    add_column :users, :family_note, :text
  end
end
