class AddCategoryToAllergen < ActiveRecord::Migration
  def change
    add_column :allergens, :category, :string
  end
end
