module WelcomeHelper

  # Show prompt to join and prep, pay, or purchase a new session
  def user_appointment_prompt(upcoming_appointment, unpaid_appointment)
    
    if upcoming_appointment && upcoming_appointment.status == "Paid"  
      render "welcome/home/upcoming_confirmed_appointment", upcoming_appointment: upcoming_appointment 

    elsif upcoming_appointment && upcoming_appointment.status ==  "Follow Up Unpaid"
      render "welcome/home/upcoming_unconfirmed_appointment", upcoming_appointment: unpaid_appointment 

    else 
      render "welcome/home/no_upcoming_appointment" 
    end 
  end

  # Show join partial if appointment is starting within 10 minutes
  def upcoming_appointment_section(upcoming_appointment)
         
    if ( (DateTime.now >= upcoming_appointment.start_time - 10.minutes) ) 
      render "welcome/home/join_session_section", upcoming_appointment: upcoming_appointment 

    else 
     render "welcome/home/prep_session_section", upcoming_appointment: upcoming_appointment 
    end 
  end

  # Show dietitian name or partial
  def dietitian_name_prompt
    if current_dietitian.first_name == nil 
      render "welcome/index/add_dietitian_name_button" 
    else 
      current_dietitian.first_name 
    end 
  end

  # Show dietitian avatar or partial
  def dietitian_avatar_prompt
    if current_dietitian.main_avatar != false 
      image_tag current_dietitian.main_avatar.thumb.url
    else 
      render "welcome/index/add_dietitian_avatar_button"
    end 
  end
end
