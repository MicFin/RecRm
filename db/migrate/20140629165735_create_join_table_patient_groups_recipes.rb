class CreateJoinTablePatientGroupsRecipes < ActiveRecord::Migration
  def change
  create_table :patient_groups_recipes, id: false do |t|
    t.integer :recipe_id
    t.integer :patient_group_id
  end
  end
end
