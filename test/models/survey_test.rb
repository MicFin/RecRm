# == Schema Information
#
# Table name: surveys
#
#  id              :integer          not null, primary key
#  surveyable_id   :integer
#  surveyable_type :string(255)
#  completed       :boolean          default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#  survey_group_id :integer
#  last_updated_at :datetime
#  completed_at    :datetime
#

require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
