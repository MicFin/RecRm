class MemberPlan < ActiveRecord::Base
  # users can have "Subscriber" roles with member plans objects
  resourcify
  has_many :subscriptions
  has_many :users, through: :subscriptions
  belongs_to :plan
end