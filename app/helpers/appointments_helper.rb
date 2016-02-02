# == Schema Information
#
# Table name: appointments
#
#  id                  :integer          not null, primary key
#  patient_focus_id    :integer
#  appointment_host_id :integer
#  dietitian_id        :integer
#  room_id             :integer
#  note                :text
#  client_note         :text
#  created_at          :datetime
#  updated_at          :datetime
#  start_time          :datetime
#  end_time            :datetime
#  stripe_card_token   :string(255)
#  regular_price       :integer
#  invoice_price       :integer
#  duration            :integer
#  other_note          :text
#  time_slot_id        :integer
#  status              :string(255)
#  registration_stage  :integer          default(0)
#  client_prepped      :boolean
#  dietitian_prepped   :boolean
#

module AppointmentsHelper

  # Get upcoming appointments for a dietitian or client, and next appointment for dietitian
  def get_upcoming_appointments!

    # Create upcoming appointments array
    @upcoming_appointments = []

    # Set user to current dietitian or current user
    user = current_dietitian || current_user

    # If user is an Admin Dietitian then get all upcoming appointments
    if user.has_role? "Admin Dietitian"
      list_of_appointments = Appointment.upcoming_and_current.by_start_time

    # If user is a client then get all of their upcoming appointments
    elsif user.is_a? User 
      list_of_appointments = user.appointment_hosts.upcoming_and_current.by_start_time

    # If user is neither a client or Admin Dietitian then is a dietitian so get all of their upcoming appointments
    else
      list_of_appointments = user.appointments.upcoming_and_current.by_start_time
    end

    # Build family and add to appointments
    # only uses patient focus when a user not a dietitian
    list_of_appointments.includes(:appointment_host).includes(:patient_focus).map do |appointment| 
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

  end

  # Get previous appointments (marked as Complete) for a dietitian or client
  def get_previous_appointments!
    @previous_appointments = []

    # if dietitian then get all previous appointments and add family
    if current_dietitian
      current_dietitian.appointments.complete.includes(:appointment_host).includes(:patient_focus).map do |appointment| 
          family = appointment.appointment_host.head_of_families.last 
          family.health_groups_names = family.health_groups.map(&:name)
          family.age_groups = family.ages
          family.number_of_members = family.family_member_count
          family.family_names = family.all_first_names
          appointment.family_info = family
          # appointment.follow_up = appointment.surveys.where(survey_type: "Follow-Up").last
          @previous_appointments << appointment
      end

    # if not dietitian then user so get all previous appointment hosts and add family
    else
      current_user.appointment_hosts.complete.includes(:appointment_host).includes(:patient_focus).map do |appointment| 
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

    # group previous appointments by date and time
    @previous_appointments = @previous_appointments.group_by{|appointment|  [appointment.start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y"), appointment.start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%I:%M%p")] }
  end

  # Get upcoming appointment for client
  def get_upcoming_appointment!

    # Get last paid appointment or last follow up unpaid appointment 
      @upcoming_appointment = current_user.appointment_hosts.upcoming_and_current.scheduled.first 

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

  def assign_appointments_prompt(appointments_no_dietitian)

    if appointments_no_dietitian.count > 0 
      render "appointments/index/appointments_no_dietitian_table", appointments_no_dietitian: appointments_no_dietitian
    else 
      render "appointments/index/appointments_no_dietitians_to_assign"  
    end   
  end

end
