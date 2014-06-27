class ChangeAmountFormatInIngredientsRecipes < ActiveRecord::Migration
  def change
    change_column :ingredients_recipes, :amount, "integer USING CAST(amount AS integer)"
  end
end
