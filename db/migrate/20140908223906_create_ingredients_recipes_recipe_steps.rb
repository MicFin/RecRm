class CreateIngredientsRecipesRecipeSteps < ActiveRecord::Migration
  def up
    create_table :ingredients_recipes_recipe_steps do |t|
      t.belongs_to :ingredients_recipe, index: true
      t.belongs_to :recipe_step, index: true
    end
    drop_table :ingredients_recipe_steps
  end

  def down
    drop_table :ingredients_recipes_recipe_steps
    create_table :ingredients_recipe_steps do |t|
      t.belongs_to :ingredient, index: true
      t.belongs_to :recipe_step, index: true
    end
  end
end
