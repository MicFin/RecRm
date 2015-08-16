class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :type
      t.string :name
      t.integer :full_price
      t.text :description
      t.integer :num_half_appointments
      t.string :num_full_appointments
      t.integer :expiration_in_months

      t.timestamps
    end
  end
end
