class AddStatusToAvailability < ActiveRecord::Migration
  def change
    add_column :availabilities, :status, :string
  end
end
