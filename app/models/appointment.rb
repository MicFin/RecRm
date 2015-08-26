class Appointment < ActiveRecord::Base
  after_save :update_purchase_price, :if => Proc.new {|model| model.duration_changed? }

  attr_accessor :family_info
  attr_accessor :prepped 
  attr_accessor :follow_up 
  attr_accessor :time 
  attr_accessor :date 
  attr_accessor :price

  belongs_to :appointment_host, :class_name => "User", :foreign_key => "appointment_host_id"
  belongs_to :patient_focus, :class_name => "User", :foreign_key => "patient_focus_id"
  belongs_to :dietitian
  belongs_to :room
  belongs_to :time_slot
  has_many :surveys, :as => :surveyable
  
  has_one :purchase, as: :purchasable


  # # Remove coupon from appointment
  # def remove_coupon

  #   # Destroy coupon redemption
  #   self.coupon_redemption.destroy unless self.coupon_redemption.nil?

  #   # Reset the appointment price
  #   reset_appointment_price
  #   self.save
  # end

  def prep_complete?
    if self.surveys.where(survey_type: "Pre-Appointment-Dietitian").where(completed: true).count > 0
      return true
    else
      return false
    end
  end

  def available_time_slots
    return TimeSlot.where(start_time: self.start_time, end_time: self.end_time, vacancy: true)
  end

  def available_dietitians
    dietitians = []
    if TimeSlot.where(start_time: self.start_time, end_time: self.end_time, vacancy: true).count > 0
      TimeSlot.where(start_time: self.start_time, end_time: self.end_time, vacancy: true).each do |time_slot|
        dietitians << time_slot.dietitian
      end
    end
    return dietitians
  end

  # find where this is used, shoudl now be using registration_stage model table column
  def stage

    if self.start_time != nil 
      return 4
    elsif self.patient_focus.sex != nil && self.start_time == nil
      return 3
    elsif self.patient_focus != nil && self.patient_focus.sex ==nil
      return 2
    else
      return 1
    end
  end
  
  def show_duration
    if self.duration == 30
      return "1/2 hour"
    else
      return "1 hour"
    end
  end

  private

    def update_purchase_price
      if self.purchase 
        self.purchase.update_pricing
      end
    end
end

# APPOINTMENT SCHEMA     
    # t.integer  "patient_focus_id"
    # t.integer  "appointment_host_id"
    # t.integer  "dietitian_id"
    # t.integer  "room_id"
    # t.text     "note"
    # t.text     "client_note"
    # t.datetime "created_at"
    # t.datetime "updated_at"
    # t.datetime "start_time"
    # t.datetime "end_time"
    # t.string   "stripe_card_token"
    # t.integer  "regular_price"
    # t.integer  "invoice_price"
    # t.string   "type"
    # t.integer  "duration"
    # t.text     "other_note"
    # t.integer  "time_slot_id"
    # t.string   "status"
    