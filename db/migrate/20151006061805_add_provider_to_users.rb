class AddProviderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :boolean, default: false
  end
end
