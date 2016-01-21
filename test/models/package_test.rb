# == Schema Information
#
# Table name: packages
#
#  id                    :integer          not null, primary key
#  category              :string(255)
#  name                  :string(255)
#  full_price            :integer
#  description           :text
#  num_half_appointments :integer
#  num_full_appointments :integer
#  expiration_in_months  :integer
#  created_at            :datetime
#  updated_at            :datetime
#

require 'test_helper'

class PackageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
