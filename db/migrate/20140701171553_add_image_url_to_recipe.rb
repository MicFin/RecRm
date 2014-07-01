class AddImageUrlToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :image_url, :text
  end
end
