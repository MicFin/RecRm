# == Schema Information
#
# Table name: survey_groups
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  version_number :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class SurveyGroup < ActiveRecord::Base

  has_many :surveys
  has_many :questions
  
end
