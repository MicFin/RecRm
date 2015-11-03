class FoodDiary < ActiveRecord::Base
  belongs_to :user
  has_many :food_diary_entries
end
