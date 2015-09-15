class UserPackage < ActiveRecord::Base
  belongs_to :user
  belongs_to :package
  after_create :generate_appointments, if: :should_generate_appointments?
  #   unless: Proc.new { |comment| comment.article.ignore_comments? }
  has_one :purchase, as: :purchasable

  private

  def generate_appointments
    
    # Get number of full and half sessions in package
    num_halfs = self.package.num_half_appointments
    num_fulls = self.package.num_full_appointments

     # Create new appointment with host, duration, status, and registration stage 2
    num_halfs.times do |i|
      Appointment.create(appointment_host_id: self.user.id, status: "Unused Package Session", duration: 30, registration_stage: 2)
    end
    num_fulls.times do |i|
      Appointment.create(appointment_host_id: self.user.id, status: "Unused Package Session", duration: 60, registration_stage: 2)
    end
    
  end

  def should_generate_appointments?

    true

  end

end