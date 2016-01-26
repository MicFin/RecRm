class AddDefaultToPatientGroupColumn < ActiveRecord::Migration

  def up
    change_column :patient_groups, :input_option, :boolean, :default => false, :null => false
  end

  def down
    change_column :patient_groups, :input_option, :boolean
  end

end
