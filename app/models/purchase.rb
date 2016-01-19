class Purchase < ActiveRecord::Base
  after_create :update_pricing

  belongs_to :user

  # Only allow one coupon redemption per purchase
  has_one :coupon_redemption
  has_one :coupon, through: :coupon_redemption

  # Purchasable is either an Appointment or a Package for now
  belongs_to :purchasable, polymorphic: true

  # Returns invoice cost in humanized format
  def show_invoice_cost
    return "$"+'%.2f' % (invoice_cost.to_i/100.0)
  end

  # Returns invoice price in humanized format
  def show_invoice_price
    return "$"+'%.2f' % (invoice_price.to_i/100.0)
  end

  # Returns the difference between the invoice cost and invoice price
  def invoice_discount
    invoice_cost - invoice_price
  end

  # Returns true if purchase is discounted, false if not
  def is_discounted?
    invoice_cost < invoice_price
  end

  def update_with_payment(credit_card_usage, purchasable)
        
    # if purchase is valid
    if valid?

      # Skip payment for invoices less than or equal to 0
      if invoice_price > 0 

        # create new customer or find current customer
        if user.stripe_id
          customer = Stripe::Customer.retrieve(user.stripe_id)
        else
   
          # if creating a new customer and wants to save CC
          if credit_card_usage == "remember_me"
            customer = Stripe::Customer.create(:card => stripe_card_token, :description => user.email, :email => user.email)

          # if creating a new customer and does not want to save CC
          else
            customer = Stripe::Customer.create(:description => user.email, :email => user.email)
          end
          # add stripe customer id to user
          user.stripe_id = customer.id
          user.save
          self.save!
        end

        
        # set stripe_id variable now that it is created
        stripe_id = user.stripe_id

        # if customer wanted to remember card
        if credit_card_usage == "remember_me"
          begin
            charge = Stripe::Charge.create(
            :customer    => stripe_id,
            :amount      => invoice_price,
            :description => 'Kindrdfood 1 Hour',
            :currency    => 'usd'
          )
          rescue Stripe::CardError => e
            # The card has been declined
            flash[:error] = e.message
            logger.error "Stripe error while creating customer: #{e.message}"
            errors.add :base, "There was a problem with your credit card."

            # if error set stripe card token to nil
            self.stripe_card_token = nil 
            self.save!
            
          end

        # if custeomr did not want to remember card need to change to not create stripe customer
        else 
          
          begin
            charge = Stripe::Charge.create(
            :card        => stripe_card_token,
            :amount      => invoice_price,
            :description => 'Kindrdfood 1 Hour',
            :currency    => 'usd'
          )
          rescue Stripe::CardError => e
            # The card has been declined
            flash[:error] = e.message
            logger.error "Stripe error while creating customer: #{e.message}"
            errors.add :base, "There was a problem with your credit card."

            # if error set stripe card token to nil
            self.stripe_card_token = nil 
            self.save
            
          end
        end
      end    

      
      if self.stripe_card_token == ""
        self.stripe_card_token = nil 
        self.save
      end
      ### If Stripe fails then these should not be run
      ### But it probably does
      ### Need to test
      # Mark purchase as paid
      self.status = "Paid"

      # Mark Appointment as Paid
      if purchasable.class == Appointment
        purchasable.status = "Paid"
        purchasable.save
      end

      # Complete any coupon redemptions used
      if self.coupon_redemption
        CouponRedeemer.complete_redemption(self.coupon_redemption)
      end

      save!
    end
  end

  # Apply coupon to purchase 
  # optional coupon parameter or get last coupon
  def redeem_coupon(purchasable, coupon=nil)
    
    # if a coupon is passed in and there is another coupon attached
    # destroy the other coupon redemption
    # and reset the pruchase price
    if coupon && self.coupon_redemption
      self.coupon_redemption.destroy
      reset_invoice_price(purchasable)
    end

    # If a coupon is passed in then create new CouponRedemption
    if coupon 
        
      # Create CouponRedemption with status of Incomplete
      redemption = CouponRedemption.create(coupon_id: coupon.id, user_id: self.user_id, status: "Applied", purchase_id: self.id)
      
    # No coupon passed in then check if there is a coupon already applied
    else
      
      if self.coupon_redemption
        coupon = self.coupon_redemption.coupon
      end
    end  

    # if a coupon was passed in or is attached to purchase then
    if !coupon.nil?

      # set regular invoice price
      cost = self.invoice_cost

      # if coupon type is percentage then
      # change invoice price to discounted by percent
      if coupon.amount_type.downcase == "percent"
        self.invoice_price = cost - ( cost * (coupon.amount * 0.01).to_i )

      # if coupon type is not percentage then it is dollar amount 
      # change invoice price to be discounted by dollar amount
      else
        
        self.invoice_price = cost - (coupon.amount * 100)
      end
      
      # save purchase
      self.save
    end
  end

  def update_pricing

    # If purchasable is Appointment
    if purchasable_type == "Appointment" 
      appointment = Appointment.find(purchasable_id)
      
      # Reset invoice price
      reset_invoice_price(appointment)
      self.save

      # Redeem any discounts applied to purchase
      redeem_coupon(appointment)

    # If purchasable is Package
    else
      package = Package.find(purchasable_id)

      # Reset invoice price
      reset_invoice_price(package)
      self.save

      # Redeem any discounts applied to purchase
      redeem_coupon(package)
    end
  end

  # Remove coupon from purchase
  def remove_coupon

    # Destroy coupon redemption
    self.coupon_redemption.destroy unless self.coupon_redemption.nil?
      
    # Reset the appointment price
    # must save afterwards
    appointment = Appointment.find(purchasable_id)
    reset_invoice_price(appointment)
    self.save
  end

  private


    # Resets purchase invoice prices
    def reset_invoice_price(purchasable)

      # If purchasable is an Appointment
      if purchasable.class == Appointment 
        duration = purchasable.duration

        # Regular price
        if duration == 30
          self.invoice_cost = 6900
        else
          self.invoice_cost = 10900
        end

        # Tara referral invoice pricing
        if user.tara_referral == true 
          if duration == 30
            self.invoice_price = 4900
          else
            self.invoice_price = 8900
          end

        # QOL invoice pricing
        elsif user.qol_referral == true 
          self.invoice_price = 0

        # Unused package session pricing
        elsif purchasable.status == "Unused Package Session"
          self.invoice_price = 0

        # No Discount invoice pricing
        else
          if duration == 30
            self.invoice_price = 6900
          else
            self.invoice_price = 10900
          end
        end

      # If purchasable is a Package
      else
        price = purchasable.full_price
        self.invoice_cost = price
        self.invoice_price = price
      end
    end

end