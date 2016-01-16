class DropPatientGroupsRecipesTable < ActiveRecord::Migration
  def change
drop_table :patient_groups_recipes do |t|
        t.integer "recipe_id"
    t.integer "patient_group_id"
end
  end
end
