# == Schema Information
#
# Table name: availabilities
#
#  id                  :integer          not null, primary key
#  start_time          :datetime
#  end_time            :datetime
#  buffered_start_time :datetime
#  buffered_end_time   :datetime
#  dietitian_id        :integer
#  created_at          :datetime
#  updated_at          :datetime
#  status              :string(255)
#

class Availability < ActiveRecord::Base
  belongs_to :dietitian
  has_many :time_slots 
  before_destroy :cancel_related_time_slots

  def cancel_related_time_slots 
    
    self.time_slots.where(vacancy: true).each do |time_slot|

        ## if a time slot start time is great than or equal to the availablity and is before the availabiltiy end time then mark it as cancelled and remove vacancies
        if ( ( (time_slot.start_time >= (self.start_time) ) ) && ( (time_slot.start_time < (self.end_time) ) ) )
          time_slot.status = "Cancelled by Dietitian"
          time_slot.vacancy = false
          time_slot.save
        end
    end
  end

end
