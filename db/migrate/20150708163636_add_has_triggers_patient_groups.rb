class AddHasTriggersPatientGroups < ActiveRecord::Migration
 def change
    add_column :patient_groups, :has_triggers, :boolean, null: false, default: false
  end
end
