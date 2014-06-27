class CreateJoinTableRecipesAttributes < ActiveRecord::Migration
  def change
    create_table :recipes_attributes do |t|
      t.integer :recipe_id
      t.integer :attribute_id
    end

    add_index :recipes_attributes, :recipe_id
    add_index :recipes_attributes, :attribute_id
  end
end
