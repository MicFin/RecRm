class Purchase < ActiveRecord::Base
  belongs_to :user
  has_many :coupon_redemptions
end
