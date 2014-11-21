class Appointment < ActiveRecord::Base
  belongs_to :appointment_host, :class_name => "User", :foreign_key => "appointment_host_id"
  belongs_to :patient_focus, :class_name => "User", :foreign_key => "patient_focus_id"
  belongs_to :dietitian
  belongs_to :room
  
  def update_with_payment
    # if appointment is valid
    if valid?
      binding.pry
      # create new customer or find current customer
      if appointment_host.stripe_id
        customer = Stripe::Customer.retrieve(appointment_host.stripe_id)
      else
        customer = Stripe::Customer.create(:card => stripe_card_token, :description => self.appointment_host.email)
        self.appointment_host.stripe_id = customer.id
        save!
      end
      stripe_id = appointment_host.stripe_id
      # charge customer
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

    end
  end

end
