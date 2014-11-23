class AddAttributesToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :trial_end, :datetime
    add_column :subscriptions, :trial_start, :datetime
    add_column :subscriptions, :ended_at, :datetime
    add_column :subscriptions, :current_period_start, :datetime
    add_column :subscriptions, :current_period_end, :datetime
    add_column :subscriptions, :cancelled_at, :datetime
    add_column :subscriptions, :status, :string
    add_column :subscriptions, :quantity, :integer, :default => 1
    add_column :subscriptions, :stripe_id, :integer
  end
end
