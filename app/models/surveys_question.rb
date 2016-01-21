# == Schema Information
#
# Table name: surveys_questions
#
#  id          :integer          not null, primary key
#  survey_id   :integer
#  question_id :integer
#  answer      :text
#  created_at  :datetime
#  updated_at  :datetime
#

class SurveysQuestion < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question 

end
