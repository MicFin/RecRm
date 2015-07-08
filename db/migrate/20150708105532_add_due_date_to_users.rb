class AddDueDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :due_date, :datetime
  end
end
