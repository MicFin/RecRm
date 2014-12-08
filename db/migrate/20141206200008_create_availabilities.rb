class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.datetime :start_time 
      t.datetime :end_time
      t.datetime :buffered_start_time 
      t.datetime :buffered_end_time
      t.belongs_to :dietitian, index: true
      t.timestamps
    end
  end
end
