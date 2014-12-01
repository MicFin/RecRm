class AddOtherNoteToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :other_note, :text
  end
end
