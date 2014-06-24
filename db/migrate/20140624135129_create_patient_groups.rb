class CreatePatientGroups < ActiveRecord::Migration
  def change
    create_table :patient_groups do |t|
      t.string :name
      t.string :category
      t.text :description
      t.integer :order
      t.boolean :input_option
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
