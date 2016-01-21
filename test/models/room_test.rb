# == Schema Information
#
# Table name: rooms
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  sessionId    :string(255)
#  public       :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  dietitian_id :integer
#

require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
