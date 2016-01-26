# == Schema Information
#
# Table name: appointments
#
#  id                  :integer          not null, primary key
#  patient_focus_id    :integer
#  appointment_host_id :integer
#  dietitian_id        :integer
#  room_id             :integer
#  note                :text
#  client_note         :text
#  created_at          :datetime
#  updated_at          :datetime
#  start_time          :datetime
#  end_time            :datetime
#  stripe_card_token   :string(255)
#  regular_price       :integer
#  invoice_price       :integer
#  duration            :integer
#  other_note          :text
#  time_slot_id        :integer
#  status              :string(255)
#  registration_stage  :integer          default(0)
#  client_prepped      :boolean
#  dietitian_prepped   :boolean
#

class Appointment < ActiveRecord::Base

  # # ATTRIBUTE ACCESSORS
  attr_accessor :family_info
  attr_accessor :prepped 
  attr_accessor :follow_up 
  attr_accessor :time 
  attr_accessor :date 
  attr_accessor :price

  # # SCOPES

  # SCOPES: Upcoming and previous appointments
  scope :upcoming, -> { where("start_time > ?", DateTime.now) }
  scope :previous, -> { where("start_time < ?", DateTime.now) }
  scope :upcoming_and_current, -> { where("start_time > ?", DateTime.now - 1.hours) }

  # SCOPES: Appointment statuses
  scope :in_registration, -> { where(status: 'In Registration') } 
  scope :scheduled, -> { where(status: ['Paid', "Follow Up Unpaid"]) } 
  scope :follow_up_unpaid, -> { where(status: 'Follow Up Unpaid') } 
  scope :paid, -> { where(status: 'Paid') } 
  scope :complete, -> { where(status: 'Complete') } 
  scope :has_status, ->(status_string) { where status: status_string }

  # SCOPES: Appointment owners
  scope :unassigned, -> { where(dietitian_id: nil) }

  # SCOPES: Appointment order
  scope :by_start_time, -> { order(start_time: :asc, created_at: :asc) }

  # # CALL BACKS
  after_save :update_purchase_price, :if => Proc.new {|model| model.duration_changed? }

  # # RELATIONSHIPS
  belongs_to :appointment_host, :class_name => "User", :foreign_key => "appointment_host_id"
  belongs_to :patient_focus, :class_name => "User", :foreign_key => "patient_focus_id"
  belongs_to :dietitian
  belongs_to :room
  belongs_to :time_slot
  has_many :surveys, :as => :surveyable
  has_one :purchase, as: :purchasable


  # # METHODS

  def dietitian_prep_complete?
    if self.surveys.where(survey_group_id: 3).where(completed: true).count > 0
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
