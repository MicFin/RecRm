# == Schema Information
#
# Table name: coupons
#
#  id                :integer          not null, primary key
#  code              :string(255)
#  description       :string(255)
#  valid_from        :datetime
#  valid_until       :datetime
#  redemption_limit  :integer          default(1)
#  redemptions_count :integer          default(0)
#  amount            :integer
#  amount_type       :string(255)
#  status            :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

require 'test_helper'

class CouponTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
