class DropCharacteristicsRecipesTable < ActiveRecord::Migration
  def change
  drop_table :characteristics_recipes do |t|
    t.integer :recipe_id
    t.integer :characteristic_id
  end
  end
end
