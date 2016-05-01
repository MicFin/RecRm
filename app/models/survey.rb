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

class Survey < ActiveRecord::Base



  belongs_to :survey_group
  belongs_to :surveyable, :polymorphic => true
  has_many :surveys_questions, -> { includes :question }, :dependent => :destroy
  has_many :questions, through: :surveys_questions

  # Generates questions for survey based on survey group
  def generate_survey_questions
    self.survey_group.questions.each do |question|
      SurveysQuestion.create(question_id: question.id, survey_id: self.id)
    end
  end

  # Generates or fetches the survey used as Pre Appointment Survey for client or dietitian
  def self.generate_for_appointment(appointment, client_or_dietitian)
    # for client
    if client_or_dietitian.class == User

      client_pre_appt_survey_group_id = SurveyGroup.client_pre_appt.most_recent.id

      appointment_survey = Survey.where(survey_group_id: client_pre_appt_survey_group_id).where(surveyable_type: "Appointment").where(surveyable_id: appointment.id)

      if appointment_survey.count < 1
        
        new_survey = Survey.new(survey_group_id: client_pre_appt_survey_group_id)
        new_survey.surveyable_id = appointment.id
        new_survey.surveyable_type = "Appointment"
        new_survey.save
        new_survey.generate_survey_questions
        
        new_survey.save
      else
        new_survey = appointment_survey.last
      end

      # for dietitian
    else 

      dietitian_pre_appt_survey_group_id = SurveyGroup.dietitian_pre_appt.most_recent.id
      
      appointment_survey = Survey.where(survey_group_id: dietitian_pre_appt_survey_group_id).where(surveyable_type: "Appointment").where(surveyable_id: appointment.id)

      if appointment_survey.count < 1
        
        new_survey = Survey.new(survey_group_id: dietitian_pre_appt_survey_group_id)
        new_survey.surveyable_id = appointment.id
        new_survey.surveyable_type = "Appointment"
        new_survey.save
        new_survey.generate_survey_questions
        
        new_survey.save
      else
        new_survey = appointment_survey.last
      end
    end
    return new_survey
  end

  # Generates or fetches the survey used as Notes for In Session for client or dietitian
  def self.generate_for_session(appointment, client_or_dietitian)
    if client_or_dietitian.class == User

      client_session_notes_survey_group_id = SurveyGroup.client_session_notes.most_recent.id

      appointment_survey = Survey.where(survey_group_id: client_session_notes_survey_group_id).where(surveyable_type: "Appointment").where(surveyable_id: appointment.id)

      if appointment_survey.count < 1
        
        new_survey = Survey.new(survey_group_id: client_session_notes_survey_group_id)
        new_survey.surveyable_id = appointment.id
        new_survey.surveyable_type = "Appointment"
        new_survey.save
        new_survey.generate_survey_questions
        
        new_survey.save
      else
        new_survey = appointment_survey.last
      end

    # else for dietitian
    else 

      dietitian_session_notes_survey_group_id = SurveyGroup.dietitian_session_notes.most_recent.id

      appointment_survey = Survey.where(survey_group_id: dietitian_session_notes_survey_group_id).where(surveyable_type: "Appointment").where(surveyable_id: appointment.id)

      if appointment_survey.count < 1
        
        new_survey = Survey.new(survey_group_id: dietitian_session_notes_survey_group_id)
        new_survey.surveyable_id = appointment.id
        new_survey.surveyable_type = "Appointment"
        new_survey.save
        new_survey.generate_survey_questions
        
        new_survey.save
      else
        new_survey = appointment_survey.last
      end

    end
    return new_survey
  end

  # should consider removing
  def self.generate_for_post_appointment(appointment, client_or_dietitian)
    
    if client_or_dietitian.class ==  User
      client = client_or_dietitian
      new_survey = Survey.new(survey_type: "Post-Appointment-Client")
      new_survey.surveyable_id = appointment.id
      new_survey.surveyable_type = "Appointment"
      new_survey.user = client
      new_survey.save
      Question.new(position: 1, tier: 1, content: "Did you enjoy this appointment?", question_type: "Radio", survey_group: "Post-Appointment-Client", survey_group_question_id: 1, choices: "Yes, No", survey_id: new_survey.id).save
      Question.new(position: 2, tier: 2, content: "Please explain what you liked or disliked about this experience.", question_type: "Response", survey_group: "Post-Appointment-Client", survey_group_question_id: 2, choices: "", survey_id: new_survey.id).save
      Question.new(position: 3, tier: 1, content: "Did we address your 3 biggest challenges?", question_type: "Response", survey_group: "Post-Appointment-Client", survey_group_question_id: 3, choices: "", survey_id: new_survey.id).save
      Question.new(position: 4, tier: 1, content: "Are there any other resources that you would like us to share or research for you?", question_type: "Response", survey_group: "Post-Appointment-Client", survey_group_question_id: 4, choices: "", survey_id: new_survey.id).save
      Question.new(position: 5, tier: 1, content: "Is there anything that we did not cover that you would like more guidance with?", question_type: "Response", survey_group: "Post-Appointment-Client", survey_group_question_id: 4, choices: "", survey_id: new_survey.id).save      
      new_survey.save
    else
      dietitian = client_or_dietitian
      new_survey = Survey.new(survey_type: "Post-Appointment-Dietitian")
      new_survey.surveyable_id = appointment.id
      new_survey.surveyable_type = "Appointment"
      # new_survey.user = dietitian
      new_survey.save
      Question.new(position: 1, tier: 1, content: "Was the client's child present during the appointment?", question_type: "Radio", survey_group: "Post-Appointment-Dietitian", survey_group_question_id: 1, choices: "Yes, No", survey_id: new_survey.id).save
      Question.new(position: 2, tier: 1, content: "Did you schedule a follow up? (please give date and time or timing, EX 2 weeks)", question_type: "Response", survey_group: "Post-Appointment-Dietitian", survey_group_question_id: 2, choices: "", survey_id: new_survey.id).save
      Question.new(position: 3, tier: 1, content: "What was the most difficult thing about this session? (think about what you would share with the group)", question_type: "Response", survey_group: "Post-Appointment-Dietitian", survey_group_question_id: 3, choices: "", survey_id: new_survey.id).save
      Question.new(position: 4, tier: 1, content: "What do you think went well during this session? (think about what you would share with the group)", question_type: "Response", survey_group: "Post-Appointment-Dietitian", survey_group_question_id: 4, choices: "", survey_id: new_survey.id).save
      Question.new(position: 5, tier: 1, content: "Was there anything that you had to look up, reference, or use outside of the system?", question_type: "Response", survey_group: "Post-Appointment-Dietitian", survey_group_question_id: 5, choices: "", survey_id: new_survey.id).save
      Question.new(position: 6, tier: 1, content: "Please let us know how the system worked.  Was it smooth? Lacking? A nuisance?  Don't hold back, this is being made for YOU!", question_type: "Response", survey_group: "Post-Appointment-Dietitian", survey_group_question_id: 6, choices: "", survey_id: new_survey.id).save
      new_survey.save
    end
    return new_survey
  end

  def self.generate_for_follow_up(appointment)
    new_survey = Survey.new(survey_type: "Follow-Up")
    new_survey.surveyable_id = appointment.id
    new_survey.surveyable_type = "Appointment"
    client = appointment.appointment_host
    new_survey.user = client
    new_survey.save
    Question.new(position: 1, tier: 1, content: "Write the assessment that will be sent to #{client.first_name} #{client.last_name}:", question_type: "Response", survey_group: "Follow-Up", survey_group_question_id: 1, choices: "", survey_id: new_survey.id).save
    Question.new(position: 2, tier: 1, content: "Prepare an assessment to send to your client's physician:", question_type: "Response", survey_group: "Follow-Up", survey_group_question_id: 2, choices: "", survey_id: new_survey.id).save
    new_survey.save 
    return new_survey
  end
end
