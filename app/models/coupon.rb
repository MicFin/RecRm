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

class Coupon < ActiveRecord::Base

  has_many :coupon_redemptions
  has_many :purchases, through: :coupon_redemptions
  has_many :users, through: :coupon_redemptions

  def redeemed
    self.redemptions_count = self.redemptions_count + 1
    if self.redemption_limit <= self.redemptions_count 
      self.status = "Out of Stock"
    end
    save
  end

  def self.generate_code   
    # now = Time.now.utc.to_date
    # age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    # super(age) #must add this otherwise you need to add this thing and place the value which you want to save. 
  end

  # def code=(value)
  #   # # custom actions
  #   # ###
  #   # write_attribute(:code, value)
  #   # # this is same as self[:code] = value
  # end


end
