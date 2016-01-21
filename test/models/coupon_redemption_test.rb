# == Schema Information
#
# Table name: coupon_redemptions
#
#  id          :integer          not null, primary key
#  coupon_id   :integer
#  user_id     :integer
#  purchase_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  status      :string(255)
#

require 'test_helper'

class CouponRedemptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
