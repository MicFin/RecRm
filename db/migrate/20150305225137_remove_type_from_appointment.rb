class RemoveTypeFromAppointment < ActiveRecord::Migration
  def change
    remove_column :appointments, :type
  end
end
