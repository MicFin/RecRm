class Plan < ActiveRecord::Base
  # user can have a "Member" role with plan object
  resourcify
  has_many :member_plans
end
