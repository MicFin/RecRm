# == Schema Information
#
# Table name: subscriptions
#
#  id                   :integer          not null, primary key
#  member_plan_id       :integer
#  user_id              :integer
#  start_date           :datetime
#  end_date             :datetime
#  type                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  trial_end            :datetime
#  trial_start          :datetime
#  ended_at             :datetime
#  current_period_start :datetime
#  current_period_end   :datetime
#  cancelled_at         :datetime
#  status               :string(255)
#  quantity             :integer          default(1)
#  stripe_id            :integer
#

module SubscriptionsHelper
end
