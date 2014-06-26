class CreateRecipeSteps < ActiveRecord::Migration
  def change
    create_table :recipe_steps do |t|
      t.integer :step_number
      t.text :directions
      t.integer :recipe_id
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end

    add_index :recipe_steps, :recipe_id
  end
end
