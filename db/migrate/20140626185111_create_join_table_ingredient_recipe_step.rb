class CreateJoinTableIngredientRecipeStep < ActiveRecord::Migration
  def change
    create_join_table :ingredients, :recipe_steps do |t|
      # t.index [:ingredient_id, :recipe_step_id]
      # t.index [:recipe_step_id, :ingredient_id]
    end

    add_index :ingredients_recipe_steps, :recipe_step_id
    add_index :ingredients_recipe_steps, :ingredient_id
  end
end
