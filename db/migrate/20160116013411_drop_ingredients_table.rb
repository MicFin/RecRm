class DropIngredientsTable < ActiveRecord::Migration
  def change
    drop_table :ingredients do |t|
      t.string   :name
      t.string   :category
      t.datetime :created_at
      t.datetime :updated_at
      t.boolean  :common_allergen
    end
  end
end
