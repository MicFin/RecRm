class Purchase < ActiveRecord::Base
  belongs_to :user
  has_many :coupon_redemptions
  belongs_to :purchasable, polymorphic: true
end
