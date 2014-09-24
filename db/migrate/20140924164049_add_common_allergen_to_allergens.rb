class AddCommonAllergenToAllergens < ActiveRecord::Migration
  def change
    add_column :allergens, :common_allergen, :boolean
  end
end
