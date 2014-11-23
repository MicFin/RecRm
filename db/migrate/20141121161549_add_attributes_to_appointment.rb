class AddAttributesToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :regular_price, :integer
    add_column :appointments, :invoice_price, :integer
    add_column :appointments, :type, :string
    add_column :appointments, :duration, :integer
  end
end
