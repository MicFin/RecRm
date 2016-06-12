module Dietitians
  class DietitianPresenter < SimpleDelegator

    def previous_appointments_patient_focus
      # user.patient_focus gets all appointments where user is patient_Focus
      Appointments::AppointmentPresenter.present(patient_focus.complete)
    end

    def last_sign_in
       last_sign_in_at.in_time_zone("Eastern Time (US & Canada)").strftime("%A %B %d, %Y %I:%M %p")
    end

    def created
       created_at.in_time_zone("Eastern Time (US & Canada)").strftime("%A %B %d, %Y %I:%M %p")
    end


    # # CLASS METHODS
    def self.present(dietitians)
      dietitians.map { |dietitian| Dietitians::DietitianPresenter.new(dietitian) }
    end
  end
end