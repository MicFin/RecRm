class AppointmentMailWorker
  include Sidekiq::Worker

  def perform(appointment_id, appointment_mailer)
    appointment = Appointment.find(appointment_id)
        # Get appointment start time 
    start_time = appointment.start_time

    # For confirmation
    if appointment_mailer == "confirmation"
      # Send appointment confirmation
      UserMailer.appointment_confirmation(appointment_id).deliver

      # If appointment is more than 6 days away then send a notice 3 days before
      if start_time > (DateTime.now + 6.days)
        AppointmentMailWorker.perform_at(3.days.until(start_time), user_id, "reminder_3_day")

      # else if appt is greater than 1 day away send a 1 day notice
      elsif start_time > (DateTime.now + 3.days)
        AppointmentMailWorker.perform_at(1.day.until(start_time), user_id, "reminder_1_day")

      # else if appt is greater than 1 day away set send a 1 hour notice
      # elsif start_time > (DateTime.now + 1.days)

      # else set 1 hour reminder
      else
        AppointmentMailWorker.perform_at(1.hour.until(start_time), user_id, "reminder_1_hour")
      end

    # For 3 day reminder
    elsif appointment_mailer == "reminder_3_day"

      UserMailer.appointment_reminder_3_day(appointment_id).deliver
      AppointmentMailWorker.perform_at(1.day.until(start_time), user_id, "reminder_1_day")

    # For 1 day reminder
    elsif appointment_mailer == "reminder_1_day"
      UserMailer.appointment_reminder_1_day(appointment_id).deliver
      AppointmentMailWorker.perform_at(1.hour.until(start_time), user_id, "reminder_1_hour")

    # For 1 hour reminder
    elsif appointment_mailer == "reminder_1_hour"
      UserMailer.appointment_reminder_1_hour(appointment_id).deliver

    # for assessment ready
    elsif appointment_mailer == "assessment_ready"
      UserMAiler.appointment_assessment_ready(appointment_id).deliver

    # For 5 mins late
    elsif appointment_mailer == "late_5_mins"
      UserMailer.appointment_late_5_minutes(appointment_id).deliver

    # For missed appointment
    elsif appointment_mailer == "missed"
      UserMailer.appointment_missed(appointment_id).deliver

    # For no appointment mailer do nothing
    else
     false
     
    end

    # case appointment_mailer
    # when "confirmation"
    #   UserMailer.appointment_confirmation(appointment_id).deliver
    # when "reminder_3_day"
    #   UserMailer.appointment_reminder_3_day(appointment_id).deliver
    # when "reminder_1_day"
    #   UserMailer.appointment_reminder_1_day(appointment_id).deliver
    # when "reminder_1_hour"
    #   UserMailer.appointment_reminder_1_hour(appointment_id).deliver
    # when "late_5_mins"
    #   UserMailer.appointment_late_5_minutes(appointment_id).deliver
    # when "missed"
    #   UserMailer.appointment_missed(appointment_id).deliver
    # else
    #   false
    # end    
  end

end
