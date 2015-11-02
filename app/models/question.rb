class Question < ActiveRecord::Base
  belongs_to :survey_group
  has_many :survey_questions 
  has_many :surveys, through: :survey_questions
end
