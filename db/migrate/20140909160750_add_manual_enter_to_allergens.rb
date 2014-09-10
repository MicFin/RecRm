class AddManualEnterToAllergens < ActiveRecord::Migration
  def change
    add_column :allergens, :manual_enter, :boolean
  end
end
