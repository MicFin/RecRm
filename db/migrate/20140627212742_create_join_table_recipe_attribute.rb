class CreateJoinTableRecipeAttribute < ActiveRecord::Migration
  def change
    create_join_table :recipes, :attributes do |t|
    end
    
    add_index :recipes_attributes, :recipe_id
    add_index :recipes_attributes, :attribute_id
  end
  end
end
