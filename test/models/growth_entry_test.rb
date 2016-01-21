# == Schema Information
#
# Table name: growth_entries
#
#  id                  :integer          not null, primary key
#  growth_chart_id     :integer
#  measured_at         :date
#  height_in_inches    :integer
#  weight_in_ounces    :integer
#  age                 :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  height_percentile   :integer
#  height_z_score      :integer
#  weight_percentile   :integer
#  weight_z_score      :integer
#  bmi_percentile      :integer
#  bmi_z_score         :integer
#  dietitian_note      :text
#  client_note         :text
#  energy_requirement  :string(255)
#  protein_requirement :integer
#  fluids_requirement  :integer
#

require 'test_helper'

class GrowthEntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
