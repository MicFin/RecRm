class Room < ActiveRecord::Base
  has_many :appointments
  # belongs_to :dietitian
end
