class Survey < ActiveRecord::Base


  ### SURVEYS AND QUESTIONS NEED TO BE RESTRUCTURED SO THAT QUESTIONS ARE NOT CREATED EACH TIME
  belongs_to :user
  belongs_to :surveyable, :polymorphic => true
  has_many :questions, :dependent => :destroy


  # def self.generate_for_user(client, survey_user, survey_type)
    
  #   if survey_type == "User-Food"
  #     new_survey = Survey.new(survey_type: "User-Food")
  #     new_survey.surveyable_id = survey_user.id
  #     new_survey.surveyable_type = "User"
  #     new_survey.user = client
  #     new_survey.save
  #     Question.new(position: 1, tier: 1, content: "When did you first become aware of #{survey_user.first_name}'s nutritional needs?  What was that experience like? ", question_type: "Response", survey_group: "User-Food", survey_group_question_id: 1, choices: "", survey_id: new_survey.id).save
  #     Question.new(position: 2, tier: 1, content: "What foods does #{survey_user.first_name} regularly need to avoid?", question_type: "Response", survey_group: "User-Food", survey_group_question_id: 2, choices: "", survey_id: new_survey.id).save
  #     Question.new(position: 3, tier: 1, content: "What foods does #{survey_user.first_name} enjoy eating?", question_type: "Response", survey_group: "User-Food", survey_group_question_id: 3, choices: "", survey_id: new_survey.id).save
  #     Question.new(position: 4, tier: 1, content: "Describe what #{survey_user.first_name} eats on an average day (include breakfast, lunch, dinner, desserts, snacks, etc):", question_type: "Response", survey_group: "User-Food", survey_group_question_id: 4, choices: "", survey_id: new_survey.id).save
  #     Question.new(position: 5, tier: 1, content: "What are some of #{survey_user.first_name}'s favorite food brands?", question_type: "Response", survey_group: "User-Food", survey_group_question_id: 5, choices: "", survey_id: new_survey.id).save
  #     Question.new(position: 6, tier: 1, content: "What meals are the most challenging for #{survey_user.first_name} to eat properly?", question_type: "Response", survey_group: "User-Food", survey_group_question_id: 6, choices: "", survey_id: new_survey.id).save
  #     Question.new(position: 7, tier: 1, content: "What is #{survey_user.first_name} favorite homemade meal?", question_type: "Response", survey_group: "User-Food", survey_group_question_id: 7, choices: "", survey_id: new_survey.id).save
  #     Question.new(position: 8, tier: 1, content: "Does #{survey_user.first_name} see a physician?", question_type: "Radio", survey_group: "User-Food", survey_group_question_id: 8, choices: "Yes, No", survey_id: new_survey.id).save
  #   elsif survey_type == "User-Life"
  #     new_survey = Survey.new(survey_type: "User-Life")
  #     new_survey.surveyable_id = survey_user.id
  #     new_survey.surveyable_type = "User"
  #     new_survey.user = client
  #     new_survey.save
  #     Question.new(position: 1, tier: 1, content: "Does #{survey_user.first_name}'s nutritional needs affect #{survey_user.singular_possessive} performance in school? Please Explain.", question_type: "Response", survey_group: "User-Life", survey_group_question_id: 1, choices: "", survey_id: new_survey.id).save
  #     Question.new(position: 2, tier: 1, content: "Has #{survey_user.first_name} been bullied or teased due to #{survey_user.singular_possessive} nutritional needs?  Please explain.", question_type: "Response", survey_group: "User-Life", survey_group_question_id: 2, choices: "", survey_id: new_survey.id).save
  #     Question.new(position: 3, tier: 1, content: "Nutrition can be overwhelming, how would you describe #{survey_user.first_name}'s outlook on #{survey_user.singular_possessive} own nutrition?", question_type: "Response", survey_group: "User-Life", survey_group_question_id: 3, choices: "", survey_id: new_survey.id).save
  #     Question.new(position: 4, tier: 1, content: "What are some of #{survey_user.first_name}'s hobbies? Please share.", question_type: "Response", survey_group: "User-Life", survey_group_question_id: 4, choices: "", survey_id: new_survey.id).save
  #     Question.new(position: 5, tier: 1, content: "Does #{survey_user.first_name} have an favorites sports teams, musicians, or other favorites we should know about? Please share.", question_type: "Response", survey_group: "User-Life", survey_group_question_id: 5, choices: "", survey_id: new_survey.id).save
  #   else
  #     return false
  #   end
    
  #   new_survey.save
  #   return new_survey
  # end

  def self.generate_for_appointment(appointment, client_or_dietitian)
    # for client
    if client_or_dietitian.class == User
      appointment_survey = Survey.where(survey_type: "Pre-Appointment-Client").where(user_id: client_or_dietitian.id).where(surveyable_id: appointment.id).where(surveyable_type: "Appointment")
      if appointment_survey.count < 1
        
        new_survey = Survey.new(survey_type: "Pre-Appointment-Client")
        new_survey.surveyable_id = appointment.id
        new_survey.surveyable_type = "Appointment"
        new_survey.user = client_or_dietitian
        new_survey.save
        Question.new(position: 1, tier: 1, content: "What are the top 3 nutritional challenges for your child or family?", question_type: "Response", survey_group: "Pre-Appointment-Client", survey_group_question_id: 1, choices: "", survey_id: new_survey.id).save
        Question.new(position: 2, tier: 2, content: "What is the 1 thing that you would really like to accomplish during this session?", question_type: "Response", survey_group: "Pre-Appointment-Client", survey_group_question_id: 2, choices: "", survey_id: new_survey.id).save
        Question.new(position: 3, tier: 1, content: "What did #{appointment.patient_focus.first_name} eat and drink yesterday? (this snapshot, even if not a typical day, is important)", question_type: "Response", survey_group: "Pre-Appointment-Client", survey_group_question_id: 3, choices: "", survey_id: new_survey.id).save
        Question.new(position: 4, tier: 1, content: "Please share any other information that is important for understanding #{appointment.patient_focus.first_name}'s nutrition.", question_type: "Response", survey_group: "Pre-Appointment-Client", survey_group_question_id: 4, choices: "", survey_id: new_survey.id).save
        Question.new(position: 5, tier: 1, content: "It is important for our team to stay connected with your doctors to keep your care coordinated.  Please provide the name, practice or hospital and phone number of #{appointment.patient_focus.first_name}'s doctor.", question_type: "Response", survey_group: "Pre-Appointment-Client", survey_group_question_id: 5, choices: "", survey_id: new_survey.id).save
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
