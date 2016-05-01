# == Schema Information
#
# Table name: growth_charts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class GrowthChart < ActiveRecord::Base
  belongs_to :user
  has_many :growth_entries
  # default_scope{includes(:growth_entries)}
end
