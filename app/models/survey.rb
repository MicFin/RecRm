class Survey < ActiveRecord::Base



  belongs_to :survey_group
  belongs_to :surveyable, :polymorphic => true
  has_many :surveys_questions, :dependent => :destroy
  has_many :questions, through: :surveys_questions

  def generate_survey_questions
    self.survey_group.questions.each do |question|
      SurveysQuestion.create(question_id: question.id, survey_id: self.id)
    end
  end

  def self.generate_for_appointment(appointment, client_or_dietitian)
    # for client
    if client_or_dietitian.class == User

      # survey group ID 1 is pre appointment survey
      appointment_survey = Survey.where(survey_group_id: 1).where(surveyable_type: "Appointment").where(surveyable_id: appointment.id)

      if appointment_survey.count < 1
        
        new_survey = Survey.new(survey_group_id: 1)
        new_survey.surveyable_id = appointment.id
        new_survey.surveyable_type = "Appointment"
        new_survey.save
        new_survey.generate_survey_questions
        binding.pry
        # Question.new(position: 1, tier: 1, content: "What are the top 3 nutritional challenges for your child or family?", question_type: "Response", survey_group: "Pre-Appointment-Client", survey_group_question_id: 1, choices: "", survey_id: new_survey.id).save
        # Question.new(position: 2, tier: 2, content: "What is the 1 thing that you would really like to accomplish during this session?", question_type: "Response", survey_group: "Pre-Appointment-Client", survey_group_question_id: 2, choices: "", survey_id: new_survey.id).save
        # Question.new(position: 3, tier: 1, content: "What did #{appointment.patient_focus.first_name} eat and drink yesterday? (this snapshot, even if not a typical day, is important)", question_type: "Response", survey_group: "Pre-Appointment-Client", survey_group_question_id: 3, choices: "", survey_id: new_survey.id).save
        # Question.new(position: 4, tier: 1, content: "Please share any other information that is important for understanding #{appointment.patient_focus.first_name}'s nutrition.", question_type: "Response", survey_group: "Pre-Appointment-Client", survey_group_question_id: 4, choices: "", survey_id: new_survey.id).save
  
        new_survey.save
      else
        new_survey = appointment_survey.last
      end

      # for dietitian
    else 
      appointment_survey = Survey.where(survey_type: "Pre-Appointment-Dietitian").where(surveyable_id: appointment.id).where(surveyable_type: "Appointment")
      if appointment_survey.count < 1
        new_survey = Survey.new(survey_type: "Pre-Appointment-Dietitian")
        new_survey.surveyable_id = appointment.id
        new_survey.surveyable_type = "Appointment"
        new_survey.save
        Question.new(position: 1, tier: 1, content: "Client history and referring concern", question_type: "Response", survey_group: "Pre-Appointment-Dietitian", survey_group_question_id: 1, choices: "", survey_id: new_survey.id).save
        Question.new(position: 2, tier: 1, content: "#{appointment.patient_focus.first_name}'s height in centimeters", question_type: "Number", survey_group: "Pre-Appointment-Dietitian", survey_group_question_id: 2, choices: "", survey_id: new_survey.id).save
        Question.new(position: 3, tier: 1, content: "#{appointment.patient_focus.first_name}'s height % for age", question_type: "Number", survey_group: "Pre-Appointment-Dietitian", survey_group_question_id: 3, choices: "", survey_id: new_survey.id).save
        Question.new(position: 4, tier: 1, content: "#{appointment.patient_focus.first_name}'s height z-score", question_type: "Number", survey_group: "Pre-Appointment-Dietitian", survey_group_question_id: 4, choices: "", survey_id: new_survey.id).save
        Question.new(position: 5, tier: 1, content: "#{appointment.patient_focus.first_name}'s weight in kg", question_type: "Number", survey_group: "Pre-Appointment-Dietitian", survey_group_question_id: 5, choices: "", survey_id: new_survey.id).save
        Question.new(position: 6, tier: 1, content: "#{appointment.patient_focus.first_name}'s weight % for age", question_type: "Number", survey_group: "Pre-Appointment-Dietitian", survey_group_question_id: 6, choices: "", survey_id: new_survey.id).save
        Question.new(position: 7, tier: 1, content: "#{appointment.patient_focus.first_name}'s weight z-score", question_type: "Number", survey_group: "Pre-Appointment-Dietitian", survey_group_question_id: 7, choices: "", survey_id: new_survey.id).save
        Question.new(position: 8, tier: 1, content: "#{appointment.patient_focus.first_name}'s BMI", question_type: "Number", survey_group: "Pre-Appointment-Dietitian", survey_group_question_id: 8, choices: "", survey_id: new_survey.id).save
        Question.new(position: 9, tier: 1, content: "#{appointment.patient_focus.first_name}'s BMI % for age", question_type: "Number", survey_group: "Pre-Appointment-Dietitian", survey_group_question_id: 9, choices: "", survey_id: new_survey.id).save
        Question.new(position: 10, tier: 1, content: "#{appointment.patient_focus.first_name}'s BMI z-score", question_type: "Number", survey_group: "Pre-Appointment-Dietitian", survey_group_question_id: 10, choices: "", survey_id: new_survey.id).save
        Question.new(position: 11, tier: 1, content: "#{appointment.patient_focus.first_name}'s estimated energy requirement (calories)", question_type: "Number", survey_group: "Pre-Appointment-Dietitian", survey_group_question_id: 11, choices: "", survey_id: new_survey.id).save
        Question.new(position: 12, tier: 1, content: "#{appointment.patient_focus.first_name}'s protein RDA (g/day)", question_type: "Number", survey_group: "Pre-Appointment-Dietitian", survey_group_question_id: 12, choices: "", survey_id: new_survey.id).save
        Question.new(position: 13, tier: 1, content: "#{appointment.patient_focus.first_name}'s fluid (mL/day)", question_type: "Number", survey_group: "Pre-Appointment-Dietitian", survey_group_question_id: 13, choices: "", survey_id: new_survey.id).save
        Question.new(position: 14, tier: 1, content: "Assessment / Plan for #{appointment.patient_focus.first_name}", question_type: "Number", survey_group: "Pre-Appointment-Dietitian", survey_group_question_id: 14, choices: "", survey_id: new_survey.id).save
        new_survey.save
      else
        new_survey = appointment_survey.last
      end
    end
    return new_survey
  end

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
