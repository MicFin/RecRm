class AddRemoveColumnFromAllergens < ActiveRecord::Migration
  def change
    add_column :allergens, :top_allergen, :boolean
    remove_column :allergens, :common_allergen
  end
end
