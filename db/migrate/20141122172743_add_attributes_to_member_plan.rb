class AddAttributesToMemberPlan < ActiveRecord::Migration
  def change
    add_column :member_plans, :amount, :integer
    add_column :member_plans, :currency, :string, :default => "usd"
    add_column :member_plans, :interval, :string
    add_column :member_plans, :live_mode, :boolean
    add_column :member_plans, :interval_count, :integer
    add_column :member_plans, :trial_period_days, :integer
    add_column :member_plans, :statement_description, :string
  end
end
