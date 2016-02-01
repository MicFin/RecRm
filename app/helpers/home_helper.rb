module HomeHelper
  
  def user_appointment_prompt(upcoming_appointment, unpaid_appointment)
    
    if upcoming_appointment && upcoming_appointment.status == "Paid"  
      render "welcome/home/upcoming_confirmed_appointment", upcoming_appointment: upcoming_appointment 

    elsif upcoming_appointment && upcoming_appointment.status ==  "Follow Up Unpaid"
      render "welcome/home/upcoming_unconfirmed_appointment", upcoming_appointment: unpaid_appointment 

    else 
      render "welcome/home/no_upcoming_appointment" 
    end 
  end
end
