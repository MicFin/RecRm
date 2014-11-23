class AddStripeIdToMemberPlan < ActiveRecord::Migration
  def change
    add_column :member_plans, :stripe_id, :string
  end
end
