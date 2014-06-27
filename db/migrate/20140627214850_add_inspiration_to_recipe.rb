class AddInspirationToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :inspiration, :text
  end
end
