# == Schema Information
#
# Table name: member_plans
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  stripe_id             :string(255)
#  amount                :integer
#  currency              :string(255)      default("usd")
#  interval              :string(255)
#  live_mode             :boolean
#  interval_count        :integer
#  trial_period_days     :integer
#  statement_description :string(255)
#  plan_id               :integer
#

class MemberPlan < ActiveRecord::Base
  # users can have "Subscriber" roles with member plans objects
  resourcify
  has_many :subscriptions
  has_many :users, through: :subscriptions
  belongs_to :plan
end
