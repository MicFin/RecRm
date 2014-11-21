class ChangeStripeIdColumnTypeInUserTable < ActiveRecord::Migration
  def up
      change_column :users, :stripe_id, :text
  end
  def down
      change_column :users, :stripe_id, :integer
  end
end
