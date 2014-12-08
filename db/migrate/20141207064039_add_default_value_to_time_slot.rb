class AddDefaultValueToTimeSlot < ActiveRecord::Migration
def up
  change_column :time_slots, :vacancy, :boolean, :default => true
end

def down
  change_column :time_slots, :vacancy, :boolean, :default => nil
end
end
