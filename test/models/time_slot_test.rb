# == Schema Information
#
# Table name: time_slots
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  start_time      :datetime
#  end_time        :datetime
#  created_at      :datetime
#  updated_at      :datetime
#  minutes         :integer
#  status          :string(255)
#  availability_id :integer
#  vacancy         :boolean          default(TRUE)
#

require 'test_helper'

class TimeSlotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
