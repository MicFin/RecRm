class AddMinutesToTimeSlot < ActiveRecord::Migration
  def change
    add_column :time_slots, :minutes, :integer
  end
end
