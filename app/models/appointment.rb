class Appointment < ActiveRecord::Base
  belongs_to :appointment_host, :class_name => "User", :foreign_key => "appointment_host_id"
  belongs_to :patient_focus, :class_name => "User", :foreign_key => "patient_focus_id"
  belongs_to :dietitian
  belongs_to :room
  
  def stage
    if self.start_time != nil 
      return 4
    elsif self.patient_focus != nil
      if self.patient_focus.family_role != nil
        return 3
      else
        return 2
      end
    else
      return 1
    end
  end
  
  def update_with_payment(credit_card_usage)
    # if appointment is valid
    if valid?
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
          :amount      => 10000,
          :description => 'Kindrdfood Member',
          :currency    => 'usd'
        )
        rescue Stripe::CardError => e
          # The card has been declined
          flash[:error] = e.message
          logger.error "Stripe error while creating customer: #{e.message}"
          errors.add :base, "There was a problem with your credit card."
        end
      # charge custoemr
      # if custeomr did not want to remember card
      else 
        begin
          charge = Stripe::Charge.create(
          :customer    => stripe_id,
          :card        => stripe_card_token,
          :amount      => 10000,
          :description => 'Kindrdfood Member',
          :currency    => 'usd'
        )
        rescue Stripe::CardError => e
          # The card has been declined
          flash[:error] = e.message
          logger.error "Stripe error while creating customer: #{e.message}"
          errors.add :base, "There was a problem with your credit card."
        end
      end
      # save invoice price to appointment
      self.invoice_price = 10000
      self.duration = 60
      save!
    end
  end

end
