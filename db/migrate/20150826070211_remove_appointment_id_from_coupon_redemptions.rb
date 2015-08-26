class RemoveAppointmentIdFromCouponRedemptions < ActiveRecord::Migration
  def change
    remove_column :coupon_redemptions, :appointment_id
  end
end
