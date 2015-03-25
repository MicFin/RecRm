class AddEarlyAccessToUser < ActiveRecord::Migration
  def change
    add_column :users, :early_access, :boolean, :default=> false
  end
end
