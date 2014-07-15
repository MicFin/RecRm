class ChangeAmountFormatInIngredientsRecipe < ActiveRecord::Migration
  def change
     change_column :ingredients_recipes, :amount, :string
  end
end
