class AddUnverifiedToPatientGroup < ActiveRecord::Migration
  def change
    add_column :patient_groups, :unverified, :boolean, :default => false
  end
end
