# == Schema Information
#
# Table name: food_diary_entries
#
#  id            :integer          not null, primary key
#  food_diary_id :integer
#  consumed_at   :datetime
#  food_item     :string(255)
#  location      :string(255)
#  note          :text
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

class FoodDiaryEntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
