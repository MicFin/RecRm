class AddCompleteToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :complete, :boolean
  end
end
