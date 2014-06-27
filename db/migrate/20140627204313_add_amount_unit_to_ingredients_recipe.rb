class AddAmountUnitToIngredientsRecipe < ActiveRecord::Migration
  def change
    add_column :ingredients_recipes, :amount_unit, :string
  end
end
