# == Schema Information
#
# Table name: time_slots
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  start_time      :datetime
#  end_time        :datetime
#  created_at      :datetime
#  updated_at      :datetime
#  minutes         :integer
#  status          :string(255)
#  availability_id :integer
#  vacancy         :boolean          default(TRUE)
#

class TimeSlot < ActiveRecord::Base

  # # RELATIONSHIPS
  belongs_to :availability
  has_one :dietitian, through: :availability
  has_one :appointment

  # # SCOPES
  # SCOPES: Upcoming and previous time slots
  scope :upcoming, -> { where("time_slots.start_time > ?", DateTime.now) }
  scope :previous, -> { where("time_slots.start_time < ?", DateTime.now) }
  scope :upcoming_with_buffer, -> (day_buffer){ where("time_slots.start_time > ?", DateTime.now + day_buffer.days) }
  # SCOPES: Time slot statuses
  scope :current, -> { where(status: 'Current') }
  scope :cancelled, -> { where(status: 'Cancelled') } 
  scope :has_status, -> (status) { where(status: status) }
  # SCOPES: Time slot vacancy
  scope :vacant, -> { where(vacancy: true) }   
  # SCOPES: Time slot length
  scope :half_hour, -> { where(minutes: 30) } 
  scope :full_hour, -> { where(minutes: 60) } 
  scope :has_length, -> (minutes) { where(minutes: minutes) } 
  # SCOPES: Time slot for specific dietitian
  scope :for_dietitian, -> (dietitian_id) { joins(:availability).where("availabilities.dietitian_id=?", dietitian_id) if dietitian_id.present? }
  # SCOPES: Time slot order
  scope :by_start_time, -> { order(start_time: :desc) }

  # # CLASS METHODS

  ## check if time slot is between two times
  def self.between(start_time, end_time)
    where('start_at > :lo and start_at < :up',
      :lo => TimeSlot.format_date(start_time),
      :up => TimeSlot.format_date(end_time)
    )
  end

  def self.select_appointment_time_slots
    
    self.where(vacancy: true).where(status: "Current").where(minutes: 60).where("start_time > ?", DateTime.now + 2.days )

  end

  ## format date for database
  def self.format_date(date_time)
   Time.at(date_time.to_i).to_formatted_s(:db)
  end

  def self.cancel_related_time_slots(time_slot) 
    taken_slot_start_time = time_slot.start_time
    taken_slot_end_time = time_slot.end_time
    
    time_slot.availability.time_slots.vacant.each do |time_slot|
      ## if it is a 30 minute slot
      if time_slot.minutes == 30
        ## if it starts between 30mins before taken slots start
        if ( ( (time_slot.start_time >= (taken_slot_start_time - 30.minutes) ) ) && ( (time_slot.start_time < (taken_slot_end_time + 30.minutes) ) ) )
          time_slot.status = "Cancelled"
          time_slot.vacancy = false
          time_slot.save
        end
      # one hour time slots
      else
        ## if it starts between 30mins before taken slots start
        if ( ( (time_slot.start_time >= (taken_slot_start_time - 1.hours) ) ) && ( (time_slot.start_time < (taken_slot_end_time + 30.minutes) ) )) 
          time_slot.status = "Cancelled"
          time_slot.vacancy = false
          time_slot.save
        end
      end
    end
  end

  def self.create_from_availability(availability_object)
    
    one_hour_time_slots = []
    half_hour_time_slots = []
    new_time_slots_hash = {}
    
    ### create 1 hour time slots
    object_start_time = availability_object.buffered_start_time
    if (object_start_time.strftime("%M") == "15") || (object_start_time.strftime("%M") == "45")
      object_start_time = object_start_time + 15.minutes
    end
    temp_start_time = object_start_time
    temp_end_time = temp_start_time + 1.hours
    
    until temp_end_time > availability_object.buffered_end_time do 

      # all schedules go live

      # if ( (availability_object.dietitian.has_role? "Tier 2 Dietitian") || (availability_object.dietitian.has_role? "Admin Dietitian") ) 
          new_time = TimeSlot.new(start_time: temp_start_time, end_time: temp_end_time, status: "Current", minutes: 60, vacancy: true, availability_id: availability_object.id)
      # else
      #   new_time = TimeSlot.new(start_time: temp_start_time, end_time: temp_end_time, status: "Training", minutes: 60, vacancy: true, availability_id: availability_object.id)
      # end
      new_time.save
      one_hour_time_slots << new_time
      temp_start_time = temp_start_time + 30.minutes
      temp_end_time = temp_start_time + 1.hours
    end
    ### create half hour time slots
    # set start and end time for looping
    temp_half_hour_start_time = object_start_time
    temp_half_hour_end_time = temp_half_hour_start_time + 30.minutes
    # until end time is beyond limit then keep making more time slots
    until temp_half_hour_end_time > availability_object.buffered_end_time do 
      ## All time slots go live
      # if ( (availability_object.dietitian.has_role? "Tier 2 Dietitian") || (availability_object.dietitian.has_role? "Admin Dietitian") )
        new_time = TimeSlot.new(start_time: temp_half_hour_start_time, end_time: temp_half_hour_end_time, status: "Current", minutes: 30, vacancy: true, availability_id: availability_object.id)
      # else
      #   new_time = TimeSlot.new(start_time: temp_half_hour_start_time, end_time: temp_half_hour_end_time, status: "Training", minutes: 30, vacancy: true, availability_id: availability_object.id)
      # end
      new_time.save
      half_hour_time_slots << new_time
      temp_half_hour_start_time = temp_half_hour_start_time + 30.minutes
      temp_half_hour_end_time = temp_half_hour_start_time + 30.minutes
    end
    # mark availability as Live since time slots have been made
    availability_object.status = "Live"
    availability_object.save

    new_time_slots_hash["half_hour_time_slots"] = half_hour_time_slots
    new_time_slots_hash["one_hour_time_slots"] = one_hour_time_slots
    
    return new_time_slots_hash
  end

  # returns a hash of the new time slots created based on the availabilities that were sent to it
  # returns {"half_hour_time_slots"=>[TimeSlotObject, TimeSlotObject], "one_hour_time_slots"=>[TimeSlotObject, TimeSlotObject] }
  def self.create_from_availabilities(array_of_availability_objects)
    
    one_hour_time_slots = []
    half_hour_time_slots = []
    array_of_availability_objects.each do |availability_object|
  

        ### create 1 hour time slots
        object_start_time = availability_object.buffered_start_time
        if (object_start_time.strftime("%M") == "15") || (object_start_time.strftime("%M") == "45")
          object_start_time = object_start_time + 15.minutes
        end
        temp_start_time = object_start_time
        temp_end_time = temp_start_time + 1.hours
        
        until temp_end_time > availability_object.buffered_end_time do 
          ## All time slots go live
          
          # if ( (availability_object.dietitian.has_role? "Tier 2 Dietitian") || (availability_object.dietitian.has_role? "Admin Dietitian") ) 
            new_time = TimeSlot.new(start_time: temp_start_time, end_time: temp_end_time, status: "Current", minutes: 60, vacancy: true, availability_id: availability_object.id)
          # else
          #   new_time = TimeSlot.new(start_time: temp_start_time, end_time: temp_end_time, status: "Training", minutes: 60, vacancy: true, availability_id: availability_object.id)
          # end
          new_time.save
          one_hour_time_slots << new_time
          temp_start_time = temp_start_time + 30.minutes
          temp_end_time = temp_start_time + 1.hours
        end
        ### create half hour time slots
        # set start and end time for looping
        temp_half_hour_start_time = object_start_time
        temp_half_hour_end_time = temp_half_hour_start_time + 30.minutes
        # until end time is beyond limit then keep making more time slots
        until temp_half_hour_end_time > availability_object.buffered_end_time do 
          new_time = TimeSlot.new(start_time: temp_half_hour_start_time, end_time: temp_half_hour_end_time, status: "Current", minutes: 30, vacancy: true, availability_id: availability_object.id)
          new_time.save
          half_hour_time_slots << new_time
          temp_half_hour_start_time = temp_half_hour_start_time + 30.minutes
          temp_half_hour_end_time = temp_half_hour_start_time + 30.minutes
        end
        # mark availability as Live since time slots have been made
        availability_object.status = "Live"
        availability_object.save
    end
    new_time_slots_hash = {}
    new_time_slots_hash["half_hour_time_slots"] = half_hour_time_slots
    new_time_slots_hash["one_hour_time_slots"] = one_hour_time_slots

    return new_time_slots_hash
  end

  # # INSTANCE METHODS

  ## json response
  def as_json(options = {})
    { 
      :id => self.id,
      :title => self.title,
      :start => start_at.rfc822,
      :end => end_at.rfc822,
      :allDay => allDay,
      :user_name => self.user_name,
      :url => Rails.application.routes.url_helpers.time_slots_path(id),
      :color => "green"
    }
  end

  def related_time_slots
    self_start_time = self.start_time
    self_end_time = self.end_time
    time_slots_array = []
    self.availability.time_slots.vacant.each do | time_slot|
       ## if it is a 30 minute slot
      if ((time_slot.minutes == 30) && (time_slot != self) )
        ## if it starts between 30mins before taken slots start
        if ( ( (time_slot.start_time >= (self_start_time - 30.minutes) ) ) && ( (time_slot.start_time < (self_end_time + 30.minutes) ) ) )
          time_slots_array << time_slot
        end
      # one hour time slots
      elsif ((time_slot.minutes == 60) && (time_slot != self) )
        ## if it starts between 30mins before taken slots start
        if ( ( (time_slot.start_time >= (self_start_time - 1.hours) ) ) && ( (time_slot.start_time < (self_end_time + 30.minutes) ) ) )
          time_slots_array << time_slot
        end
      else
        # nothing
      end
    end
    return time_slots_array
  end

  def related_time_slots_count
    return self.related_time_slots.count
  end



  def is_last_vacant_time_slot?
    if (TimeSlot.where(start_time: self.start_time, end_time: self.end_time, vacancy: true).count > 1)
      return false 
    else
      return true
    end
  end


end
