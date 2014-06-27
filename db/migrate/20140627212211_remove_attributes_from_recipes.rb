class RemoveAttributesFromRecipes < ActiveRecord::Migration
  def change
    remove_column :recipes, :cook_time, :string
    remove_column :recipes, :prep_time, :string
    remove_column :recipes, :difficulty, :string
    remove_column :recipes, :course, :string
    remove_column :recipes, :age_group, :string
    remove_column :recipes, :target_group, :string
    remove_column :recipes, :taste, :string
  end
end
