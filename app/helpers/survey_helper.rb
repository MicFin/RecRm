module SurveyHelper

  def survey_form_template(survey, surveyable, survey_group)

    # If a client pre appointment survey 
    if survey_group == "Client - Pre Appointment"

      # Gather data necessary for going along with survey
      patient_focus = surveyable.patient_focus.includes(:growth_chart).includes(:food_diary)
      growth_chart = patient_focus.growth_chart || GrowthChart.create(user_id: patient_focus.id)
      growth_entry = GrowthEntry.new(growth_chart_id: growth_chart.id)
      food_diary = patient_focus.food_diary || FoodDiary.create(user_id: patient_focus.id)
      food_diary_entry = FoodDiaryEntry.new(food_diary_id: food_diary.id)

      # Render survey template with data
      render "surveys/survey_templates/client_pre_appt_survey", survey: survey, survey_group: survey_group, surveyable: surveyable, patient_focus: patient_focus, growth_chart: growth_chart, growth_entry: growth_entry, food_diary: food_diary, food_diary_entry: food_diary_entry, remote_boolean: false 

    # If a diettiian pre appointment survey 
    elsif survey_group == "Dietitian - Pre Appointment" 

      # Gather data necessary for going along with survey
      client = Users::UserPresenter.new(surveyable.appointment_host)
      survey = Survey.generate_for_appointment(surveyable, client)
      dietitian_survey = Survey.generate_for_appointment(surveyable, surveyable.dietitian)
      surveyable = Appointments::AppointmentPresenter.new(surveyable)
      family = surveyable.family
      # Render survey template with data
      render "surveys/survey_templates/krdn_pre_appt_survey", survey: survey, survey_group: survey_group, surveyable: surveyable, dietitian_survey: dietitian_survey, family: family
    else 
      # render "purchases/purchases_modal/coupon_not_applied", purchase: purchase, purchasable: purchasable
    end
  end


end
