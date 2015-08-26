class AddCompletedAtToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :completed_at, :datetime
  end
end
