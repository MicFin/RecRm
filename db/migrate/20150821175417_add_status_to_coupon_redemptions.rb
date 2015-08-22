class AddStatusToCouponRedemptions < ActiveRecord::Migration
  def change
    add_column :coupon_redemptions, :status, :string
  end
end
