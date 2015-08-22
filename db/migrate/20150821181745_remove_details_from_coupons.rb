class RemoveDetailsFromCoupons < ActiveRecord::Migration
  def change
    remove_reference :coupons, :appointment, index: true
    remove_reference :coupons, :user, index: true
  end
end
