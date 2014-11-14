class AddStartTimeEndTimeToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :start_time, :datetime
    add_column :appointments, :end_time, :datetime
    remove_column :appointments, :date
  end
end
