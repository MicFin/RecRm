class AddDetailsToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :stripe_card_token, :string
    add_column :purchases, :invoice_price, :integer
    add_column :purchases, :invoice_cost, :integer
    add_column :purchases, :status, :string
  end
end
