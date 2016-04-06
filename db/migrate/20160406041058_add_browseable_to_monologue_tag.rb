class AddBrowseableToMonologueTag < ActiveRecord::Migration
  def change
    add_column :monologue_tags, :browseable, :boolean, :default => true, :null => false
    add_column :monologue_tags, :showcase, :boolean, :default => false, :null => false
    add_column :monologue_tags, :showcase_position, :integer, :default => 0, :null => false
  end
end
