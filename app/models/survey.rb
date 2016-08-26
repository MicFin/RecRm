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
  has_many :surveys_questions, -> { includes(:question).order("questions.position ASC") }, :dependent => :destroy
  has_many :questions, through: :surveys_questions

  # Generates questions for survey based on survey group
  def generate_survey_questions

    # For Dietitian Session Notes, create answers for questinos index 0 and 3 with pre appt survey answer 0 and 1
    if survey_group.name == "Dietitian - Session Notes"

      # Get most recent pre appt survey group
      pre_appt_survey_group_id = SurveyGroup.with_group_name("Dietitian - Pre Appointment").most_recent.id

      # Get dietititna pre appt survey
      dietitian_pre_appt_survey = Survey.where(surveyable_type: "Appointment").where(surveyable_id: surveyable.id).where(survey_group_id: pre_appt_survey_group_id).first

      # Add answers to 0 and 3
      survey_group.questions.each_with_index do |question, index|
        if index == 0
          SurveysQuestion.create(question_id: question.id, survey_id: self.id, answer: dietitian_pre_appt_survey.surveys_questions[0].answer)
        elsif index == 3
          SurveysQuestion.create(question_id: question.id, survey_id: self.id, answer: dietitian_pre_appt_survey.surveys_questions[1].answer)
        else
          SurveysQuestion.create(question_id: question.id, survey_id: self.id)
        end
      end

    elsif survey_group.name == "Client - Assessment"
      # Get most recent  session notes and client pre appoinemnt
      notes_survey_group_id = SurveyGroup.with_group_name("Dietitian - Session Notes").most_recent.id
      pre_appt_survey_group_id = SurveyGroup.with_group_name("Client - Pre Appointment").most_recent.id

      # Get surveys
      dietitian_notes = Survey.where(surveyable_type: "Appointment").where(surveyable_id: surveyable.id).where(survey_group_id: notes_survey_group_id).first

      pre_appt_survey =  Survey.where(surveyable_type: "Appointment").where(surveyable_id: surveyable.id).where(survey_group_id: pre_appt_survey_group_id).first

      # Add answers to 0 and 3
      survey_group.questions.each_with_index do |question, index|
        if index == 0
          SurveysQuestion.create(question_id: question.id, survey_id: self.id, answer: dietitian_notes.surveys_questions[1].answer)
        elsif index == 1
          SurveysQuestion.create(question_id: question.id, survey_id: self.id, answer: pre_appt_survey.surveys_questions[1].answer)
        elsif index == 2
          SurveysQuestion.create(question_id: question.id, survey_id: self.id, answer: pre_appt_survey.surveys_questions[2].answer)
        elsif index == 3
          SurveysQuestion.create(question_id: question.id, survey_id: self.id, answer: dietitian_notes.surveys_questions[3].answer)
        elsif index == 5
          SurveysQuestion.create(question_id: question.id, survey_id: self.id, answer: dietitian_notes.surveys_questions[4].answer)
        else
          SurveysQuestion.create(question_id: question.id, survey_id: self.id)
        end
      end
    elsif survey_group.name == "Provider - Assessment"
      # Get most recent Client - Assessment
      client_assessment_group_id = SurveyGroup.with_group_name("Client - Assessment").most_recent.id

      # Get dietititna pre appt survey
      dietitian_notes = Survey.where(surveyable_type: "Appointment").where(surveyable_id: surveyable.id).where(survey_group_id: notes_survey_group_id).first

      client_assessment =  Survey.where(surveyable_type: "Appointment").where(surveyable_id: surveyable.id).where(survey_group_id: client_assessment_group_id).first

      # Add answers to 0 and 3
      survey_group.questions.each_with_index do |question, index|
        if index == 0
          SurveysQuestion.create(question_id: question.id, survey_id: self.id, answer: client_assessment.surveys_questions[0].answer)
        elsif index == 2
          SurveysQuestion.create(question_id: question.id, survey_id: self.id, answer: client_assessment.surveys_questions[4].answer)
        elsif index == 3
          SurveysQuestion.create(question_id: question.id, survey_id: self.id, answer: client_assessment.surveys_questions[5].answer)
        else
          SurveysQuestion.create(question_id: question.id, survey_id: self.id)
        end
      end

    # For all others surveys leave answer blank
    else
      survey_group.questions.each_with_index do |question, index|
        SurveysQuestion.create(question_id: question.id, survey_id: self.id)
      end
    end
  end

  # Generates or fetches the survey used as Pre Appointment Survey for client or dietitian
  def self.generate_for_appointment(appointment, client_or_dietitian)
    # for client
    if client_or_dietitian.class == User || client_or_dietitian.class == Users::UserPresenter

      survey_id = SurveyGroup.with_group_name("Client - Pre Appointment").most_recent.id

      appointment_survey = Survey.where(surveyable_type: "Appointment").where(surveyable_id: appointment.id).where(survey_group_id: survey_id)

      if appointment_survey.count < 1
        
        appointment_survey = Survey.new(survey_group_id: survey_id)
        appointment_survey.surveyable_id = appointment.id
        appointment_survey.surveyable_type = "Appointment"
        appointment_survey.save
        appointment_survey.generate_survey_questions
        
        appointment_survey.save
      else
        appointment_survey = appointment_survey.last
      end

      # for dietitian
    else 

      survey_id = SurveyGroup.with_group_name("Dietitian - Pre Appointment").most_recent.id
      
      appointment_survey = Survey.where(surveyable_type: "Appointment").where(surveyable_id: appointment.id).where(survey_group_id: survey_id)

      if appointment_survey.count < 1
        
        appointment_survey = Survey.new(survey_group_id: survey_id)
        appointment_survey.surveyable_id = appointment.id
        appointment_survey.surveyable_type = "Appointment"
        appointment_survey.save
        appointment_survey.generate_survey_questions
        
        appointment_survey.save
      else
        appointment_survey = appointment_survey.last
      end
    end
    return appointment_survey
  end

  # Generates or fetches the survey used as Notes for In Session for client or dietitian
  def self.generate_for_session(appointment, client_or_dietitian)
    if client_or_dietitian.class == User

      client_session_notes_survey_group_id = SurveyGroup.with_group_name("Client - Session Notes").most_recent.id

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

      dietitian_session_notes_survey_group_id = SurveyGroup.with_group_name("Dietitian - Session Notes").most_recent.id

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
    
      client_post_appt_survey_group_id = SurveyGroup.with_group_name("Client - Post Appointment").most_recent.id

      appointment_survey = Survey.where(survey_group_id: client_post_appt_survey_group_id).where(surveyable_type: "Appointment").where(surveyable_id: appointment.id)

      if appointment_survey.count < 1
        
        new_survey = Survey.new(survey_group_id: client_post_appt_survey_group_id)
        new_survey.surveyable_id = appointment.id
        new_survey.surveyable_type = "Appointment"
        new_survey.save
        new_survey.generate_survey_questions
        
        new_survey.save
      else
        new_survey = appointment_survey.last
      end
    else
      dietitian_post_appt_survey_group_id = SurveyGroup.with_group_name("Dietitian - Post Appointment").most_recent.id

      appointment_survey = Survey.where(survey_group_id: dietitian_post_appt_survey_group_id).where(surveyable_type: "Appointment").where(surveyable_id: appointment.id)

      if appointment_survey.count < 1
        
        new_survey = Survey.new(survey_group_id: dietitian_post_appt_survey_group_id)
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

  def self.generate_for_assessment(appointment, client_or_dietitian)
   # for client
    if client_or_dietitian.class == User || client_or_dietitian.class == Users::UserPresenter


      survey_id = SurveyGroup.with_group_name("Client - Assessment").most_recent.id
      
      appointment_survey = Survey.where(surveyable_type: "Appointment").where(surveyable_id: appointment.id).where(survey_group_id: survey_id)

      if appointment_survey.count < 1
        
        appointment_survey = Survey.new(survey_group_id: survey_id)
        appointment_survey.surveyable_id = appointment.id
        appointment_survey.surveyable_type = "Appointment"
        appointment_survey.save
        appointment_survey.generate_survey_questions
        
        appointment_survey.save
      else
        appointment_survey = appointment_survey.last
      end


    # for dietitian
    else 

      survey_id = SurveyGroup.with_group_name("Provider - Assessment").most_recent.id

      appointment_survey = Survey.where(surveyable_type: "Appointment").where(surveyable_id: appointment.id).where(survey_group_id: survey_id)

      if appointment_survey.count < 1
        
        appointment_survey = Survey.new(survey_group_id: survey_id)
        appointment_survey.surveyable_id = appointment.id
        appointment_survey.surveyable_type = "Appointment"
        appointment_survey.save
        appointment_survey.generate_survey_questions
        
        appointment_survey.save
      else
        appointment_survey = appointment_survey.last
      end
    end
    return appointment_survey
  end
end
