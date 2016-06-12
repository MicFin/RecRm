class AddDisplayNameToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :display_name, :string
  end
end
