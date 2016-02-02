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

  # # SCOPES
  # SCOPES: type of survey
  scope :client_pre_appt, -> { where(name: "Client - Pre Appointment") }  
  scope :dietitian_pre_appt, -> { where(name: "Dietitian - Pre Appointment") }
  scope :client_session_notes, -> { where(name: "Client - Session Notes") }
  scope :dietitian_session_notes, -> { where(name: "Dietitian - Session Notes") } 
  scope :with_group_name, -> (group_name){ where(name: group_name) } 
  # SCOPES: order
  scope :most_recent, -> {order('version_number DESC').first}


  # # RELATIONSHIPS
  has_many :surveys
  has_many :questions
  
end
