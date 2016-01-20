module AppointmentsHelper

  # Get upcoming appointments for a dietitian or client, and next appointment for dietitian
  def get_upcoming_appointments!

    # Create upcoming appointments array
    @upcoming_appointments = []

    # Set user to current dietitian or current user
    user = current_dietitian || current_user

    # If user is an Admin Dietitian then get all upcoming appointments
    if user.has_role? "Admin Dietitian"
      list_of_appointments = Appointment.where("start_time > ?", DateTime.now).order('start_time ASC, created_at ASC')

    # If user is a client then get all of their upcoming appointments
    elsif user.is_a? User 
      list_of_appointments = user.appointment_hosts.where("start_time > ?", DateTime.now).order('start_time ASC, created_at ASC')

    # If user is neither a client or Admin Dietitian then is a dietitian so get all of their upcoming appointments
    else
      list_of_appointments = user.appointments.where("start_time > ?", DateTime.now).order('start_time ASC, created_at ASC')
    end

    # Build family and add to appointments
    list_of_appointments.map do |appointment| 
      family = appointment.appointment_host.head_of_families.last 
      family.health_groups_names = family.health_groups.map(&:name)
      family.age_groups = family.ages
      family.number_of_members = family.family_member_count
      family.family_names = family.all_first_names
      appointment.family_info = family

      # if prep is complete then mark as prepped
      appointment.prepped = appointment.dietitian_prep_complete?

      # add to upcoming appointments array
      @upcoming_appointments << appointment
    end

    # Group upcoming appoinments by data and time
    @upcoming_appointments = @upcoming_appointments.group_by{|appointment|  [appointment.start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y"), appointment.start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%I:%M%p")] }

    # If user is a dietitian then set next appointment, add family and mark if prepped
    if user.is_a? Dietitian 
      @next_appointment = user.appointments.where(status: "Paid").where(start_time: 30.minutes.ago..5.hours.from_now).last
      if @next_appointment != nil  
        family = @next_appointment.appointment_host.head_of_families.last 
        family.health_groups_names = family.health_groups.map(&:name)
        family.age_groups = family.ages
        family.number_of_members = family.family_member_count
        family.family_names = family.all_first_names
        @next_appointment.family_info = family
        @next_appointment.prepped = @next_appointment.dietitian_prep_complete?
      end
    end
  end

  # Get previous appointments (marked as Complete) for a dietitian or client
  def get_previous_appointments!
    @previous_appointments = []

    # if dietitian then get all previous appointments and add family
    if current_dietitian
      current_dietitian.appointments.includes(:appointment_host).includes(:patient_focus).map do |appointment| 
        if appointment.status == "Complete"
          family = appointment.appointment_host.head_of_families.last 
          family.health_groups_names = family.health_groups.map(&:name)
          family.age_groups = family.ages
          family.number_of_members = family.family_member_count
          family.family_names = family.all_first_names
          appointment.family_info = family
          # appointment.follow_up = appointment.surveys.where(survey_type: "Follow-Up").last
          @previous_appointments << appointment
        end
      end

    # if not dietitian then user so get all previous appointment hosts and add family
    else
      current_user.appointment_hosts.map do |appointment| 
        if appointment.status == "Complete"
          family = appointment.appointment_host.head_of_families.last 
          family.health_groups_names = family.health_groups.map(&:name)
          family.age_groups = family.ages
          family.number_of_members = family.family_member_count
          family.family_names = family.all_first_names
          appointment.family_info = family
          # appointment.follow_up = appointment.surveys.where(survey_type: "Follow-Up").last
          @previous_appointments << appointment
        end
      end
    end

    # group previous appointments by date and time
    @previous_appointments = @previous_appointments.group_by{|appointment|  [appointment.start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y"), appointment.start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%I:%M%p")] }
  end

  # Get upcoming appointment for client
  def get_upcoming_appointment!

    # Get last paid appointment or last follow up unpaid appointment 
    # - 1 hours to include appointments that are currently on going
      @upcoming_appointment = current_user.appointment_hosts.where("start_time > ?", DateTime.now - 1.hours).where(status: "Paid").last || current_user.appointment_hosts.where("start_time > ?", DateTime.now - 1.hours).where(status: "Follow Up Unpaid").last

      # If there is an upcoming appointment then set date
      if @upcoming_appointment 
        @upcoming_appointment.date = @upcoming_appointment.start_time.strftime("%A, %b %d") unless @upcoming_appointment.nil?
        @upcoming_appointment.time = @upcoming_appointment.start_time.strftime("%I:%M%p") unless @upcoming_appointment.nil?
      end
  end

  # Get last unpaid appointmnet for client
  def get_unpaid_appointment!
    # Set unpaid appointment if there is one
    @unpaid_appointment = current_user.appointment_hosts.where(status: "Follow Up Unpaid").last
  end

  # Get appointment family info
  def get_appointment_family_info!

    @family = @appointment.appointment_host.head_of_families.first
    if !@family.nil?
      @family.children = @family.users
      @family.family_members = []
      @family.family_members << @family.children << @appointment.appointment_host
      @family.family_members.flatten!
    end

  end


end
