class AddMainOptionalToIngredientsRecipe < ActiveRecord::Migration
  def change
    add_column :ingredients_recipes, :main_ingredient, :boolean
    add_column :ingredients_recipes, :optional_ingredient, :boolean
  end
end
