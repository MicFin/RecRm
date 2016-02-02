
module RoomsHelper

  def show_room_for(user, survey, appointment, pre_appt_survey)
    if user.class == Dietitian 
      render "/rooms/dietitians/dietitian_session", survey: survey, appointment: appointment, pre_appt_survey: pre_appt_survey
    else
      render "/rooms/users/user_session", :survey: survey, appointment: appointment, pre_appt_survey: pre_appt_survey 
    end 
  end
end
