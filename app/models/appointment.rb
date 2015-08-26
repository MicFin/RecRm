class Appointment < ActiveRecord::Base
  before_save :update_appointment_price, :if => Proc.new {|model| model.duration_changed? }

  attr_accessor :family_info
  attr_accessor :prepped 
  attr_accessor :follow_up 
  attr_accessor :time 
  attr_accessor :date 
  attr_accessor :price

  belongs_to :appointment_host, :class_name => "User", :foreign_key => "appointment_host_id"
  belongs_to :patient_focus, :class_name => "User", :foreign_key => "patient_focus_id"
  belongs_to :dietitian
  belongs_to :room
  belongs_to :time_slot
  has_many :surveys, :as => :surveyable
  
  has_one :purchase, as: :purchasable
  has_one :coupon_redemption
  has_one :coupon, through: :coupon_redemption

  # Apply coupon to appointment 
  # optional coupon parameter or get last coupon
  def redeem_coupon(coupon=nil)

    # if a coupon is passed in and there is another coupon attached
    # destroy the other coupon
    # and reset the appointment price
    if coupon && self.coupon_redemption
      self.coupon_redemption.destroy
      reset_appointment_price
    end

    # If a coupon is passed in then create new CouponRedemption
    if coupon 
      
      # Create CouponRedemption with status of Incomplete
      redemption = CouponRedemption.create(coupon_id: coupon.id, user_id: self.appointment_host.id, appointment_id: self.id, status: "Applied")

    # No coupon passed in then check if there is a coupon already applied
    else
      if self.coupon_redemption
        coupon = self.coupon_redemption.coupon
      end
    end  

    # if a coupon was passed in or is attached to appointment then
    if !coupon.nil?

      # set regular invoice price
      regular_price = self.invoice_price

      # if coupon type is percentage then
      # change invoice price to discounted by percent
      if coupon.amount_type.downcase == "percent"
        self.invoice_price = regular_price - ( regular_price * (coupon.amount * 0.01).to_i )

      # if coupon type is not percentage then it is dollar amount 
      # change invoice price to be discounted by dollar amount
      else
        self.invoice_price = regular_price - (coupon.amount * 100)
      end

      # save appointment
      self.save
    end
  end

  # Remove coupon from appointment
  def remove_coupon

    # Destroy coupon redemption
    self.coupon_redemption.destroy unless self.coupon_redemption.nil?

    # Reset the appointment price
    reset_appointment_price
    self.save
  end

  def prep_complete?
    if self.surveys.where(survey_type: "Pre-Appointment-Dietitian").where(completed: true).count > 0
      return true
    else
      return false
    end
  end

  def available_time_slots
    return TimeSlot.where(start_time: self.start_time, end_time: self.end_time, vacancy: true)
  end

  def available_dietitians
    dietitians = []
    if TimeSlot.where(start_time: self.start_time, end_time: self.end_time, vacancy: true).count > 0
      TimeSlot.where(start_time: self.start_time, end_time: self.end_time, vacancy: true).each do |time_slot|
        dietitians << time_slot.dietitian
      end
    end
    return dietitians
  end

  # find where this is used, shoudl now be using registration_stage model table column
  def stage

    if self.start_time != nil 
      return 4
    elsif self.patient_focus.sex != nil && self.start_time == nil
      return 3
    elsif self.patient_focus != nil && self.patient_focus.sex ==nil
      return 2
    else
      return 1
    end
  end
  
  def update_with_payment(credit_card_usage)


    # if appointment is valid
    if valid?

      # Skip payment for invoices less than or equal to 0
      if invoice_price >= 0 

        # create new customer or find current customer
        if appointment_host.stripe_id
          customer = Stripe::Customer.retrieve(appointment_host.stripe_id)
        else
          
          # if creating a new customer and wants to save CC
          if credit_card_usage == "remember_me"
            customer = Stripe::Customer.create(:card => stripe_card_token, :description => appointment_host.email, :email => appointment_host.email)

          # if creating a new customer and does not want to save CC
          else
            customer = Stripe::Customer.create(:description => appointment_host.email, :email => appointment_host.email)
          end

          # add stripe customer id to user
          appointment_host.stripe_id = customer.id
          appointment_host.save
          save!
        end

        # set stripe_id variable now that it is created
        stripe_id = appointment_host.stripe_id

        # charge customer
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
          end

        # charge custoemr
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
          end
        end
      end    

      ### If Stripe fails then these should not be run
      ### But it probably doesnt
      ### Need to test
      self.status = "Paid"

      # Complete any coupon redemptions used
      if self.coupon_redemption
        CouponRedeemer.complete_redemption(self.coupon_redemption)
      end

      save!
    end
  end

  def show_regular_price
    return "$"+'%.2f' % (self.regular_price.to_i/100.0)
  end

  def show_invoice_price
    return "$"+'%.2f' % (self.invoice_price.to_i/100.0)
  end

  def show_duration
    if self.duration == 30
      return "1/2 hour"
    else
      return "1 hour"
    end
  end

  private

  # Resets appointment price to defaults
  def reset_appointment_price

    # Regular price
    if self.duration == 30
      self.regular_price = 6999
    else
      self.regular_price = 11499
    end

    # Tara referral invoice pricing
    if self.appointment_host.tara_referral == true 
      if self.duration == 30
        self.invoice_price = 4999
      else
        self.invoice_price = 8999
      end

    # QOL invoice pricing
    elsif self.appointment_host.qol_referral == true 
        self.invoice_price = 0

    # No Discount invoice pricing
    else
      if self.duration == 30
        self.invoice_price = 6999
      else
        self.invoice_price = 11499
      end
    end

  end

  # Called before save if duration is adjusted to set regular and invoice price
  def update_appointment_price
    
    # Reset appointment price
    reset_appointment_price

    # Redeem any discounts applied to appointment
    self.redeem_coupon
  end

end

# APPOINTMENT SCHEMA     
    # t.integer  "patient_focus_id"
    # t.integer  "appointment_host_id"
    # t.integer  "dietitian_id"
    # t.integer  "room_id"
    # t.text     "note"
    # t.text     "client_note"
    # t.datetime "created_at"
    # t.datetime "updated_at"
    # t.datetime "start_time"
    # t.datetime "end_time"
    # t.string   "stripe_card_token"
    # t.integer  "regular_price"
    # t.integer  "invoice_price"
    # t.string   "type"
    # t.integer  "duration"
    # t.text     "other_note"
    # t.integer  "time_slot_id"
    # t.string   "status"
    