class AddPrep2ToIngredientsRecipe < ActiveRecord::Migration
  def change
    add_column :ingredients_recipes, :prep2, :string
  end
end
