class AddDetailsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :prep_time, :string
    add_column :recipes, :cook_time, :string
    add_column :recipes, :difficulty, :string
  end
end
