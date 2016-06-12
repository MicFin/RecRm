class AddCharacteristicsToDietitians < ActiveRecord::Migration
  def change
    add_column :dietitians, :location, :string
    add_column :dietitians, :experience_level, :integer
    add_column :dietitians, :age_level, :integer
  end
end
