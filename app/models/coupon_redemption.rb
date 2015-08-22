class CouponRedemption < ActiveRecord::Base
  # status
  #  - "Incomplete"
  #  - "Completed" 
  belongs_to :coupon
  belongs_to :user
  belongs_to :purchase
  belongs_to :appointment

end
