class TimeSlot < ActiveRecord::Base
  belongs_to :availability
  has_one :dietitian, through: :availability
  has_one :appointment
  # scope :between, lambda {|start_time, end_time| {:conditions => ["? < starts_at and starts_at < ?", Event.format_date(start_time), Event.format_date(end_time)] }}

  ## check if time slot is between two times
  def self.between(start_time, end_time)
    where('start_at > :lo and start_at < :up',
      :lo => TimeSlot.format_date(start_time),
      :up => TimeSlot.format_date(end_time)
    )
  end

  ## format date for database
  def self.format_date(date_time)
   Time.at(date_time.to_i).to_formatted_s(:db)
  end

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
        
        new_time = TimeSlot.new(start_time: temp_start_time, end_time: temp_end_time, status: "Current", minutes: 60, vacancy: true, availability_id: availability_object.id)
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

  def self.cancel_related_time_slots(time_slot) 
    taken_slot_start_time = time_slot.start_time
    taken_slot_end_time = time_slot.end_time
    
    time_slot.availability.time_slots.where(vacancy: true).each do |time_slot|
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
        if ( ( (time_slot.start_time >= (taken_slot_start_time - 1.hours) ) ) && ( (time_slot.start_time < (taken_slot_end_time + 30.minutes) ) ) )
          time_slot.status = "Cancelled"
          time_slot.vacancy = false
          time_slot.save
        end
      end
    end
    
  end


end
