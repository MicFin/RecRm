class ChangeAvailableToVacancyForTimeSlot < ActiveRecord::Migration
  def up
    remove_column :time_slots, :available
    add_column :time_slots, :vacancy, :boolean
  end
  def down
    add_column :time_slots, :available, :boolean
    remove_column :time_slots, :vacancy
  end
end
