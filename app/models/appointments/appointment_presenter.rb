module Appointments
  class AppointmentPresenter < SimpleDelegator

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

    # # CLASS METHODS
    def self.present(appointments)
      appointments.map { |appt| Appointments::AppointmentPresenter.new(appt) }
    end
  end
end