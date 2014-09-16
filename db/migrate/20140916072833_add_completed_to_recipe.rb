class AddCompletedToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :completed, :boolean, :default => false
  end
end
