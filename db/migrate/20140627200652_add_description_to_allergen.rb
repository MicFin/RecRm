class AddDescriptionToAllergen < ActiveRecord::Migration
  def change
    add_column :allergens, :description, :text, default: "No Description"
  end
end
