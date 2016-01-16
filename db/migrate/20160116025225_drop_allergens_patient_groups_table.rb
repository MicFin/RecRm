class DropAllergensPatientGroupsTable < ActiveRecord::Migration
  def change
drop_table :allergens_patient_groups do |t|
   t.integer :allergen_id,      null: false
    t.integer :patient_group_id, null: false
end
  end
end
