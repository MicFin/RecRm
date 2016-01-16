class DropAllergenIngredientTable < ActiveRecord::Migration
  def change

    drop_table :allergens_ingredients do |t|
      t.integer :allergen_id,   null: false
      t.integer :ingredient_id, null: false
    end

  end
end
