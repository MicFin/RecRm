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

  def self.redeem_coupon(coupon_code, user, purchase=nil)

    # Find active coupon
    coupon = self.find_coupon(coupon_code, user)

    # If the coupon is active apply it and return true
    
    if coupon 

      # IF 

      # Get users purchase currently in registration
      appointment = user.appointment_in_registration

      # if no appointment in registation than being applied 
      # to a purchase which is not allowed
      if appointment == nil
        return false
      end
      
      purchase = appointment.purchase

      # Apply coupon to purchase
      purchase.redeem_coupon(appointment, coupon)

      return true

    # If coupon is inactive or invalid
    else
      return false
    end
  end 

  def self.find_coupon(coupon_code, user)
    
    # Look for a coupon that meets the following conditions 
      # valid from is greater than or equal to today
      # valid until is less than or equal to today
      # coupon code matches user input and status is active
    current_coupon = self.where("valid_from <= ? AND valid_until >= ?", Date.today, Date.today).where({
        code: coupon_code,
        status: "Active"
      }).last

    # Check if current coupon exists
    # if coupon redemption limit greater than coupons redeemed
    # if redemption limit per person is greater than coupons redeemed for user
    if current_coupon && (current_coupon.redemption_limit > current_coupon.redemptions_count) && (current_coupon.redemption_limit_per_user > current_coupon.coupon_redemptions.where(:user_id => user.id).count )
      return current_coupon
    else
      return false
    end

  end

  def self.complete_redemption(coupon_redemption)

    # Get coupon
    current_coupon = coupon_redemption.coupon

    # Redeem coupon
    current_coupon.redeemed

    # Change couponredemption status to Redeemed
    coupon_redemption.status = "Redeemed"
    coupon_redemption.save

  end

  # Need an automated daily coupon expiration checker
  # def self.expire_coupons
  # end

  # def code=(value)
  #   # # custom actions
  #   # ###
  #   # write_attribute(:code, value)
  #   # # this is same as self[:code] = value
  # end

  # def self.generate_code   
  #   # now = Time.now.utc.to_date
  #   # age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  #   # super(age) #must add this otherwise you need to add this thing and place the value which you want to save. 
  # end

end
