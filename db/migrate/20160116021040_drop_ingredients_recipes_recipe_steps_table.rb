class DropIngredientsRecipesRecipeStepsTable < ActiveRecord::Migration
  def change
    drop_table :ingredients_recipes_recipe_steps do |t|
      t.integer :ingredients_recipe_id
    t.integer :recipe_step_id
    end
  end
end
