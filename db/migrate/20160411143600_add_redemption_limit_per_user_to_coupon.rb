class AddRedemptionLimitPerUserToCoupon < ActiveRecord::Migration
  def change
    add_column :coupons, :redemption_limit_per_user, :integer, :default => 1
  end
end
