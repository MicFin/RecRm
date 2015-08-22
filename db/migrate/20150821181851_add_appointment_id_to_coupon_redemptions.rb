class AddAppointmentIdToCouponRedemptions < ActiveRecord::Migration
  def change
    add_reference :coupon_redemptions, :appointment, index: true
  end
end
