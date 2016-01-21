# == Schema Information
#
# Table name: families
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  location          :string(255)
#  head_of_family_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
