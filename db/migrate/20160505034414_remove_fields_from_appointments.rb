class RemoveFieldsFromAppointments < ActiveRecord::Migration
  def change
    remove_column :appointments, :client_prepped, :boolean
    remove_column :appointments, :dietitian_prepped, :boolean
  end
end
