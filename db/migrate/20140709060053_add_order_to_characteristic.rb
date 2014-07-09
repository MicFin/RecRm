class AddOrderToCharacteristic < ActiveRecord::Migration
  def change
    add_column :characteristics, :order, :integer
  end
end
