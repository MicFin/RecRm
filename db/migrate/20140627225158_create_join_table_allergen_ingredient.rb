class CreateJoinTableAllergenIngredient < ActiveRecord::Migration
  def change
    create_join_table :allergens, :ingredients do |t|
      # t.index [:allergen_id, :ingredient_id]
      # t.index [:ingredient_id, :allergen_id]
    end

    add_index :allergens_ingredients, :allergen_id
    add_index :allergens_ingredients, :ingredient_id

  end
end
