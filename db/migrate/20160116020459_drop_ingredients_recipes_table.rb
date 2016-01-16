class DropIngredientsRecipesTable < ActiveRecord::Migration
  def change
    drop_table :ingredients_recipes do |t|
        t.integer  "ingredient_id"
    t.integer  "recipe_id"
    t.string   "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "amount_unit"
    t.boolean  "main_ingredient"
    t.boolean  "optional_ingredient"
    t.string   "display_name"
    t.integer  "position"
  end
  end
end
