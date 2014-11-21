class AddStripeCardTokenToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :stripe_card_token, :string
  end
end
