class AddQolReferralToUsers < ActiveRecord::Migration
  def change
    add_column :users, :qol_referral, :boolean, null: false, default: false
  end
end
