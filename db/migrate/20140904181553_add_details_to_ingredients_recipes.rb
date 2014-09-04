class AddDetailsToIngredientsRecipes < ActiveRecord::Migration
  def change
    add_column :ingredients_recipes, :display_name, :string
    remove_column :ingredients_recipes, :prep 
    remove_column :ingredients_recipes, :prep2
  end
end
