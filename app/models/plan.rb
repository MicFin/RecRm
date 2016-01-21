# == Schema Information
#
# Table name: plans
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Plan < ActiveRecord::Base
  # user can have a "Member" role with plan object
  resourcify
  has_many :member_plans
end
