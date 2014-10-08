class RemoveCompleteFromRecipes < ActiveRecord::Migration
  def change
    remove_column :recipes, :complete, :boolean
  end
end
