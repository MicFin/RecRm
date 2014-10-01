class AddGroupNameToRecipeSteps < ActiveRecord::Migration
  def change
    add_column :recipe_steps, :group_name, :string
  end
end
