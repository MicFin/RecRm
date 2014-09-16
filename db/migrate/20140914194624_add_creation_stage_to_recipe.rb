class AddCreationStageToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :creation_stage, :integer
  end
end
