module Appointments
  class AppointmentPresenter < SimpleDelegator

    def start_time_time
       start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%I:%M %p") 
    end

    def start_time_date
       start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%A %B %d, %Y")
    end

    def appointment_start_time
      start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y %I:%M %p")
    end

    def appointment_host_start_time_time
      start = start_time.in_time_zone(appointment_host.time_zone)
      time = start.strftime("%I:%M %p") + " " + appointment_host.time_zone 
    end

    def appointment_host_start_time_date
      start = start_time.in_time_zone(appointment_host.time_zone)
      date = start.strftime("%A %B %d, %Y")
    end

    def appointment_host_start_time
      appointment_host_start_time_date + " at " + appointment_host_start_time_time
    end

    # # INSTANCE METHODS
    def appointment_host_full_name
      Users::UserPresenter.new(appointment_host).full_name
    end

    def patient_focus_full_name
      Users::UserPresenter.new(patient_focus).full_name
    end

    def patient_focus_height
      Users::UserPresenter.new(patient_focus).height
    end

    def patient_focus_weight
      Users::UserPresenter.new(patient_focus).weight
    end

    def patient_focus_age
      Users::UserPresenter.new(patient_focus).age
    end

    def client_prep_survey_id
      Survey.joins(:survey_group).where(survey_groups: {name: "Client - Pre Appointment"}).where(surveyable_id: id).first.id
    end

    def krdn_prep_survey_id
      Survey.joins(:survey_group).where(survey_groups: {name: "Dietitian - Pre Appointment"}).where(surveyable_id: id).first.id
    end

    def family
      family = appointment_host.head_of_families.first
      family = Families::FamilyPresenter.new(family)
    end

    # # CLASS METHODS
    def self.present(appointments)
      appointments.map { |appt| Appointments::AppointmentPresenter.new(appt) }
    end
  end
end