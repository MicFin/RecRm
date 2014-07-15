class AddPrepToIngredientsRecipe < ActiveRecord::Migration
  def change
    add_column :ingredients_recipes, :prep, :string
  end
end
