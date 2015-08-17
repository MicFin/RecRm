class AddRegistrationStageToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :registration_stage, :integer, default: 0
  end
end
