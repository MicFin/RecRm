# == Schema Information
#
# Table name: patient_groups
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  category     :string(255)
#  description  :text
#  order        :integer
#  input_option :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  unverified   :boolean          default(FALSE)
#  has_triggers :boolean          default(FALSE), not null
#

require 'test_helper'

class PatientGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
