module AppointmentsHelper

  def get_upcoming_appointments!
    @upcoming_appointments = []
    user = current_dietitian || current_user
    if user.has_role? "Admin Dietitian"
      list_of_appointments = Appointment.where("start_time > ?", DateTime.now).order('start_time ASC, created_at ASC')
    elsif user.is_a? User 
      list_of_appointments = user.appointment_hosts.where("start_time > ?", DateTime.now).order('start_time ASC, created_at ASC')
    else
      list_of_appointments = user.appointments.where("start_time > ?", DateTime.now).order('start_time ASC, created_at ASC')
    end
    list_of_appointments.map do |appointment| 
      family = appointment.appointment_host.head_of_families.last 
      family.health_groups_names = family.health_groups.map(&:name)
      family.age_groups = family.ages
      family.number_of_members = family.family_member_count
      family.family_names = family.all_first_names
      appointment.family_info = family
      appointment.prepped = appointment.dietitian_prep_complete?
      @upcoming_appointments << appointment
    end
    @upcoming_appointments = @upcoming_appointments.group_by{|appointment|  [appointment.start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y"), appointment.start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%I:%M%p")] }

    if user.is_a? Dietitian 
      @next_appointment = user.appointments.where(status: "Paid").where(start_time: 30.minutes.ago..5.hours.from_now).last
      #@next_appointment = user.appointments.where(status: "Paid").last
    end
    # @next_appointment = user.appointments.where.not(status: "Follow Up Unpaid").last

    if @next_appointment != nil  
      family = @next_appointment.appointment_host.head_of_families.last 
      family.health_groups_names = family.health_groups.map(&:name)
      family.age_groups = family.ages
      family.number_of_members = family.family_member_count
      family.family_names = family.all_first_names
      @next_appointment.family_info = family
      @next_appointment.prepped = @next_appointment.prep_complete?
    end
  end

  def get_upcoming_appointment!
      # client upcoming appointment or clirent unpaid

      @upcoming_appointment = current_user.appointment_hosts.where(status: "Paid").last || current_user.appointment_hosts.where(status: "Follow Up Unpaid").last

      # start date and time 
      if @upcoming_appointment 
        @upcoming_appointment.date = @upcoming_appointment.start_time.strftime("%A, %b %d") unless @upcoming_appointment.nil?
        @upcoming_appointment.time = @upcoming_appointment.start_time.strftime("%I:%M%p") unless @upcoming_appointment.nil?

      end
  end

  def get_previous_appointments!
    @previous_appointments = []
    # if dietitian then get all previous appointments
    if current_dietitian
      current_dietitian.appointments.map do |appointment| 
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
    # if not dietitian then user so get all previous appointment hosts
    else
      current_user.appointment_hosts.map do |appointment| 
        if appointment.status == "Complete"
          family = appointment.appointment_host.head_of_families.last 
          family.health_groups_names = family.health_groups.map(&:name)
          family.age_groups = family.ages
          family.number_of_members = family.family_member_count
          family.family_names = family.all_first_names
          appointment.family_info = family
          appointment.follow_up = appointment.surveys.where(survey_type: "Follow-Up").last
          @previous_appointments << appointment
        end
      end
    end

    # group previous appointmetns by time
    @previous_appointments = @previous_appointments.group_by{|appointment|  [appointment.start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y"), appointment.start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%I:%M%p")] }
  end

  def get_unpaid_appointment!
    # Set unpaid appointment if there is one
    @unpaid_appointment = current_user.appointment_hosts.where(status: "Follow Up Unpaid").last
  end

  def get_appointment_family_info!

    @family = @appointment.appointment_host.head_of_families.first
    if !@family.nil?
      @family.children = @family.users
      @family.family_members = []
      @family.family_members << @family.children << @appointment.appointment_host
      @family.family_members.flatten!
    end

  end

  # def get_family_info!
  #   @family.health_groups_names = @family.health_groups
  #   @family.age_groups = @family.ages
  #   @family.number_of_members = @family.family_member_count
  #   @family.family_names = @family.all_first_names
  #   get_family_member_info!
  #   @family.family_member_info = @family_members
    
  # end

end
