class ChargesController < ApplicationController

  def new
  end

  def create
    
    # create new customer or find current customer
    if appointment_host.stripe_id
      customer = Stripe::Customer.retrieve(appointment_host.stripe_id)
    else
      customer = Stripe::Customer.create(:card => stripe_card_token, :description => self.appointment_host.email)
      self.appointment_host.stripe_id = customer.id
      save!
    end
    begin
      customer.subscriptions.create(:plan => "3_month")
    rescue Stripe::CardError => e
      flash.now[:error] = e.message
      redirect_to charges_path
    end
  end
end
