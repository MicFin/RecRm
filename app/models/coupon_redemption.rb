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