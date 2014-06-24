class Appointment < ActiveRecord::Base
	belongs_to :dietitian
	belongs_to :user, :foreign_key => :appointment_host_id
end
