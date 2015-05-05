class AddTaraReferralToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tara_referral, :boolean, null: false, default: false
  end
end
