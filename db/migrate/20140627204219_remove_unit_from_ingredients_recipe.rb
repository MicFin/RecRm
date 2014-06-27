class RemoveUnitFromIngredientsRecipe < ActiveRecord::Migration
  def change
    remove_column :ingredients_recipes, :unit, :string
  end
end
