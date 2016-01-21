# == Schema Information
#
# Table name: food_diaries
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class FoodDiary < ActiveRecord::Base
  belongs_to :user
  has_many :food_diary_entries
end
