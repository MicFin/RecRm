class AddObjectChangesToUserVersions < ActiveRecord::Migration
  def change
    add_column :user_versions, :object_changes, :text
  end
end
