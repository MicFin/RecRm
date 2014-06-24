class CreateJoinTableAllergensPatientGroups < ActiveRecord::Migration
  def change
    create_join_table :allergens, :patient_groups do |t|
      # t.index [:allergen_id, :patient_group_id]
      # t.index [:patient_group_id, :allergen_id]
    end

    add_index :allergens_patient_groups, :patient_group_id
    add_index :allergens_patient_groups, :allergen_id
  end
end
