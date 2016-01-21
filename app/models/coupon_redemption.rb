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

class CouponRedemption < ActiveRecord::Base
  # status
  #  - "Incomplete"
  #  - "Completed" 
  belongs_to :coupon
  belongs_to :user
  belongs_to :purchase

end

    # t.integer  "coupon_id"
    # t.integer  "user_id"
    # t.integer  "purchase_id"
    # t.datetime "created_at"
    # t.datetime "updated_at"
    # t.string   "status"
