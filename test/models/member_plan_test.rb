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

require 'test_helper'

class MemberPlanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
