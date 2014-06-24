class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :patient_focus_id
      t.integer :appointment_host_id
      t.integer :dietitian_id
      t.datetime :date
      t.integer :room_id
      t.text :note
      t.text :client_note
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
