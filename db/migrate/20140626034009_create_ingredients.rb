class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :category
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
