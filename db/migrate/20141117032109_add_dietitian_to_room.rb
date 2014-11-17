class AddDietitianToRoom < ActiveRecord::Migration
  def change
    add_reference :rooms, :dietitian, index: true
  end
end
