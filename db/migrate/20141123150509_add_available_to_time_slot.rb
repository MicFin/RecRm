class AddAvailableToTimeSlot < ActiveRecord::Migration
  def change
    add_column :time_slots, :available, :boolean, :default => true
  end
end
