class AddTimeZoneToDietitians < ActiveRecord::Migration
  def change
    add_column :dietitians, :time_zone, :string
  end
end
