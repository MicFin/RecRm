module SurveyHelper

  def survey_form_template(survey, surveyable)

    # If a client pre appointment survey 
    if survey.survey_group.name == "Client - Pre Appointment"

      # Gather data necessary for going along with survey
      patient_focus = surveyable.patient_focus
      growth_chart = patient_focus.growth_chart || GrowthChart.create(user_id: patient_focus.id)
      growth_entry = GrowthEntry.new(growth_chart_id: growth_chart.id)
      food_diary = patient_focus.food_diary || FoodDiary.create(user_id: patient_focus.id)
      food_diary_entry = FoodDiaryEntry.new(food_diary_id: food_diary.id)

      # Render survey template with data
      render "surveys/survey_templates/client_pre_appt_survey", survey: survey, surveyable: surveyable, patient_focus: patient_focus, growth_chart: growth_chart, growth_entry: growth_entry, food_diary: food_diary, food_diary_entry: food_diary_entry, remote_boolean: false 

    # If a diettiian pre appointment survey 
    elsif survey.survey_group.name == "Dietitian - Pre Appointment" 

      # Gather data necessary for going along with survey
      client = surveyable.appointment_host
      survey = Survey.generate_for_appointment(surveyable, client)
      dietitian_survey = Survey.generate_for_appointment(surveyable, surveyable.dietitian)
      surveyable = Appointments::AppointmentPresenter.new(surveyable)

      # Render survey template with data
      render "surveys/survey_templates/krdn_pre_appt_survey", survey: survey, surveyable: surveyable, dietitian_survey: dietitian_survey
    else 
      # render "purchases/purchases_modal/coupon_not_applied", purchase: purchase, purchasable: purchasable
    end
  end


end
