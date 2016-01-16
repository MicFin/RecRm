class DropRecipeStepsTable < ActiveRecord::Migration
  def change
    drop_table :recipe_steps do |t|
      t.text     :directions
      t.integer  :recipe_id
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :position
      t.string   :group_name
    end
  end
end
