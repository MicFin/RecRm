# == Schema Information
#
# Table name: user_packages
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  package_id      :integer
#  purchase_date   :date
#  expiration_date :date
#

class UserPackage < ActiveRecord::Base
  belongs_to :user
  belongs_to :package
  has_one :purchase, as: :purchasable
  has_many :appointments
  after_create :generate_appointments




  private

  def generate_appointments
    if should_generate_appointments?
      # Get number of full and half sessions in package
      num_halfs = self.package.num_half_appointments
      num_fulls = self.package.num_full_appointments
      user_id = self.user.id
      user_package_id = self.id 
      patient_focus_id = self.user.appointment_hosts.complete_or_scheduled.last.patient_focus_id
      
       # Create new appointment with host, duration, status, and registration stage 5
      num_halfs.times do |i|
        Appointment.create(appointment_host_id: user_id, patient_focus_id: patient_focus_id, status: "Unused Package Session", duration: 30, registration_stage: 5, user_package_id: user_package_id)
      end
      num_fulls.times do |i|
        Appointment.create(appointment_host_id: user_id, patient_focus_id: patient_focus_id, status: "Unused Package Session", duration: 60, registration_stage: 5, user_package_id: user_package_id)
      end
    end
  end

  def should_generate_appointments?

    true

  end

end
