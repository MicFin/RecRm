module AppointmentsHelper

  def get_upcoming_appointments!
    @upcoming_appointments = []
    current_dietitian.appointments.map do |appointment| 
      family = appointment.appointment_host.head_of_families.last 
      family.health_groups_names = family.health_groups.map(&:name)
      family.age_groups = family.ages
      family.number_of_members = family.family_member_count
      family.family_names = family.all_first_names
      appointment.family_info = family
      @upcoming_appointments << appointment
    end
    @upcoming_appointments = @upcoming_appointments.group_by{|appointment|  [appointment.start_time.to_date, appointment.start_time.strftime("%I:%M%p")] }
    # @next_appointment = current_dietitian.appointments.where(start_time: @date..1.hours.from_now).last
    binding.pry
    @next_appointment = current_dietitian.appointments.last
    if @next_appointment != nil  
      family = @next_appointment.appointment_host.head_of_families.last 
      family.health_groups_names = family.health_groups.map(&:name)
      family.age_groups = family.ages
      family.number_of_members = family.family_member_count
      family.family_names = family.all_first_names
      @next_appointment.family_info = family
    end
  end

  def get_family_member_info!
# if params[:client_first_name]
    # should create method on family model
    # this gets family members with patient focus first
    @family_members = []
  
    @family_members << @family.head_of_family
    if @family.number_of_members.to_i > 0
      @family.users.each do |family_member| 
          @family_members << family_member 
      end
    end
  end

  def get_family_info!
    @family.health_groups_names = @family.health_groups
    @family.age_groups = @family.ages
    @family.number_of_members = @family.family_member_count
    @family.family_names = @family.all_first_names
    get_family_member_info!
    @family.family_member_info = @family_members
    binding.pry
  end



end
