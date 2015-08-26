class CouponRedeemer < ActiveRecord::Base

  def self.find_coupon(coupon_code)
    
    # Look for a coupon that meets the following conditions 
      # valid from is greater than or equal to today
      # valid until is less than or equal to today
      # coupon code matches user input and status is active
    coupon = Coupon.where("valid_from <= ? AND valid_until >= ?", Date.today, Date.today).where({
        code: coupon_code,
        status: "Active"
      }).last

    # Check if coupon redemptions are maxed out
    if coupon && (coupon.redemption_limit > coupon.redemptions_count)
      return coupon
    else
      return false
    end
  end

  def self.redeem_coupon(coupon_code, user)

    # Find active coupon
    coupon = CouponRedeemer.find_coupon(coupon_code)

    # If the coupon is active apply it and return true
    if coupon 

      # Get users purchase currently in registration
      appointment = user.appointment_in_registration
      purchase = appointment.purchase

      # Apply coupon to purchase
      purchase.redeem_coupon(appointment, coupon)

      return true

    # If coupon is inactive or invalid
    else
      return false
    end
  end 

  def self.complete_redemption(coupon_redemption)

    # Get coupon
    coupon = coupon_redemption.coupon

    # Redeem coupon
    coupon.redeemed

    # Change couponredemption status to Redeemed
    coupon_redemption.status = "Redeemed"
    coupon_redemption.save

  end

  # Need an automated daily coupon expiration checker
  # def self.expire_coupons
  # end

end
