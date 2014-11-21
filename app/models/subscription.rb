class Subscription < ActiveRecord::Base
  belongs_to :member_plan
  belongs_to :user
end
