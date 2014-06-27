class RemoveCategoryFromAllergen < ActiveRecord::Migration
  def change
    remove_column :allergens, :category, :string
  end
end
