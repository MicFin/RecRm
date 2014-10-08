class AddLiveRecipeToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :live_recipe, :boolean, :null => false, :default => false
  end
end 
