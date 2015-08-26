class Purchase < ActiveRecord::Base
  belongs_to :user
  has_many :coupon_redemptions
  belongs_to :purchasable, polymorphic: true
end

    # t.integer  "user_id"
    # t.integer  "purchasable_id"
    # t.string   "purchasable_type"
    # t.datetime "created_at"
    # t.datetime "updated_at"