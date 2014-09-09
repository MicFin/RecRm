class ChangeStepOrderToPosition < ActiveRecord::Migration
  def up
    remove_column :recipe_steps, :step_number
    add_column :recipe_steps, :position, :integer
  end
  def down
    add_column :recipe_steps, :step_number, :integer
      remove_column :recipe_steps, :position
  end
end
