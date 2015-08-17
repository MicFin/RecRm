class CreateCouponRedemptions < ActiveRecord::Migration
  def change
    create_table :coupon_redemptions do |t|
      t.belongs_to :coupon, index: true
      t.belongs_to :user, index: true
      t.belongs_to :purchase, index: true
      t.timestamps
    end
  end
end
