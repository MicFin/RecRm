class AddAvailabilityIdToTimeSlot < ActiveRecord::Migration
  def change
    add_reference :time_slots, :availability, index: true
  end
end
