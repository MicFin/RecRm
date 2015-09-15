class AddPhysicianReferralToUser < ActiveRecord::Migration
  def change
    add_column :users, :physician_referral, :boolean, default: false
  end
end
