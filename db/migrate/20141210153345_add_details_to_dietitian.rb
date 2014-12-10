class AddDetailsToDietitian < ActiveRecord::Migration
  def change
    add_column :dietitians, :first_name, :string
    add_column :dietitians, :last_name, :string
    add_column :dietitians, :signature, :string
  end
end
