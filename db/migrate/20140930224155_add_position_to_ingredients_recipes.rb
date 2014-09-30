class AddPositionToIngredientsRecipes < ActiveRecord::Migration
  def change
    add_column :ingredients_recipes, :position, :integer
  end
end
