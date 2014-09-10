class AddCommonAllergenToIngredient < ActiveRecord::Migration
  def change
    add_column :ingredients, :common_allergen, :boolean
  end
end
