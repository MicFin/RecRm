class Survey < ActiveRecord::Base
  belongs_to :user
  belongs_to :surveyable, :polymorphic => true
  has_many :questions


  def self.generate_for_user(client, survey_user, survey_type)
    
    if survey_type == "User-Food"
      new_survey = Survey.new(survey_type: "User-Food")
      new_survey.surveyable_id = survey_user.id
      new_survey.surveyable_type = "User"
      new_survey.user = client
      new_survey.save
      Question.new(position: 1, tier: 1, content: "When did you first become aware of #{survey_user.first_name}'s nutritional needs?  What was that experience like? ", question_type: "Response", survey_group: "User-Food", survey_group_question_id: 1, choices: "", survey_id: new_survey.id).save
      Question.new(position: 2, tier: 1, content: "What foods does #{survey_user.first_name} regularly need to avoid?", question_type: "Response", survey_group: "User-Food", survey_group_question_id: 2, choices: "", survey_id: new_survey.id).save
      Question.new(position: 3, tier: 1, content: "What foods does #{survey_user.first_name} enjoy eating?", question_type: "Response", survey_group: "User-Food", survey_group_question_id: 3, choices: "", survey_id: new_survey.id).save
      Question.new(position: 4, tier: 1, content: "Describe what #{survey_user.first_name} eats on an average day (include breakfast, lunch, dinner, desserts, snacks, etc):", question_type: "Response", survey_group: "User-Food", survey_group_question_id: 4, choices: "", survey_id: new_survey.id).save
      Question.new(position: 5, tier: 1, content: "What are some of #{survey_user.first_name}'s favorite food brands?", question_type: "Response", survey_group: "User-Food", survey_group_question_id: 5, choices: "", survey_id: new_survey.id).save
      Question.new(position: 6, tier: 1, content: "What meals are the most challenging for #{survey_user.first_name} to eat properly?", question_type: "Response", survey_group: "User-Food", survey_group_question_id: 6, choices: "", survey_id: new_survey.id).save
      Question.new(position: 7, tier: 1, content: "What is #{survey_user.first_name} favorite homemade meal?", question_type: "Response", survey_group: "User-Food", survey_group_question_id: 7, choices: "", survey_id: new_survey.id).save
      Question.new(position: 8, tier: 1, content: "Does #{survey_user.first_name} see a physician?", question_type: "Radio", survey_group: "User-Food", survey_group_question_id: 8, choices: "Yes, No", survey_id: new_survey.id).save
    elsif survey_type == "User-Life"
      new_survey = Survey.new(survey_type: "User-Life")
      new_survey.surveyable_id = survey_user.id
      new_survey.surveyable_type = "User"
      new_survey.user = client
      new_survey.save
      Question.new(position: 1, tier: 1, content: "Does #{survey_user.first_name}'s nutritional needs affect #{survey_user.singular_possessive} performance in school? Please Explain.", question_type: "Response", survey_group: "User-Life", survey_group_question_id: 1, choices: "", survey_id: new_survey.id).save
      Question.new(position: 2, tier: 1, content: "Has #{survey_user.first_name} been bullied or teased due to #{survey_user.singular_possessive} nutritional needs?  Please explain.", question_type: "Response", survey_group: "User-Life", survey_group_question_id: 2, choices: "", survey_id: new_survey.id).save
      Question.new(position: 3, tier: 1, content: "Nutrition can be overwhelming, how would you describe #{survey_user.first_name}'s outlook on #{survey_user.singular_possessive} own nutrition?", question_type: "Response", survey_group: "User-Life", survey_group_question_id: 3, choices: "", survey_id: new_survey.id).save
      Question.new(position: 4, tier: 1, content: "What are some of #{survey_user.first_name}'s hobbies? Please share.", question_type: "Response", survey_group: "User-Life", survey_group_question_id: 4, choices: "", survey_id: new_survey.id).save
      Question.new(position: 5, tier: 1, content: "Does #{survey_user.first_name} have an favorites sports teams, musicians, or other favorites we should know about? Please share.", question_type: "Response", survey_group: "User-Life", survey_group_question_id: 5, choices: "", survey_id: new_survey.id).save
    else
      return false
    end
    
    new_survey.save
    return new_survey
  end

  def self.generate_for_appointment(appointment, client)
    
    if client.appointment_hosts.count <= 1
      new_survey = Survey.new(survey_type: "Pre-Appointment")
      new_survey.surveyable_id = appointment.id
      new_survey.surveyable_type = "Appointment"
      new_survey.user = client
      new_survey.save
      Question.new(position: 1, tier: 1, content: "Have you seen a physician or registered dietitian before?", question_type: "Radio", survey_group: "Pre-Appointment", survey_group_question_id: 1, choices: "Yes, No", survey_id: new_survey.id).save
      Question.new(position: 2, tier: 2, content: "Please explain your experience so far.", question_type: "Response", survey_group: "Pre-Appointment", survey_group_question_id: 2, choices: "", survey_id: new_survey.id).save
      Question.new(position: 3, tier: 1, content: "What are your Top 3 nutritional challenges as an entire family?", question_type: "Response", survey_group: "Pre-Appointment", survey_group_question_id: 3, choices: "", survey_id: new_survey.id).save
      Question.new(position: 4, tier: 1, content: "What is the 1 thing you would really like to accomplish during this session?", question_type: "Response", survey_group: "Pre-Appointment", survey_group_question_id: 4, choices: "", survey_id: new_survey.id).save
    end
    new_survey.save
    
    return new_survey
  end

end
