class AddTimeSlotIdAndStatusToAppointment < ActiveRecord::Migration
  def change
    add_reference :appointments, :time_slot, index: true
    add_column :appointments, :status, :string
  end
end
