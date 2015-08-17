class CouponRedemption < ActiveRecord::Base
  belongs_to :coupon
  belongs_to :user
  belongs_to :purchase
end
