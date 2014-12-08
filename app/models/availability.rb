class Availability < ActiveRecord::Base
  belongs_to :dietitian
  has_many :time_slots 

end
