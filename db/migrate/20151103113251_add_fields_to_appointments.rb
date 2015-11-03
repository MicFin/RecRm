class AddFieldsToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :client_prepped, :boolean
    add_column :appointments, :dietitian_prepped, :boolean
  end
end
