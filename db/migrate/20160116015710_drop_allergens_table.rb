class DropAllergensTable < ActiveRecord::Migration
  def change
    drop_table :allergens do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
      t.text     :description,     default: "No Description"
      t.boolean  :manual_enter
      t.boolean  :top_allergen
      t.boolean  :common_allergen
    end
  end
end
