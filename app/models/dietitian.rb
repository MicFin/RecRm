class Dietitian < ActiveRecord::Base
  attr_accessor :current_password, :image_cache, :remove_image

  rolify :role_cname => 'Role'
  scope :online, lambda{ where("updated_at > ?", 10.minutes.ago) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :appointments
  has_many :marketing_items
  has_many :articles
  has_many :recipes
  has_many :availabilities
  has_many :time_slots, through: :availabilities
  has_many :first_reviewers, :class_name => "ReviewConflict", :foreign_key => "first_reviewer_id"
  has_many :second_reviewers, :class_name => "ReviewConflict", :foreign_key => "second_reviewer_id"
  has_many :third_reviewers, :class_name => "ReviewConflict", :foreign_key => "third_reviewer_id"
  has_many :third_reviewers, :class_name => "ReviewConflict", :foreign_key => "fourth_reviewer_id"

  has_many :images, :as => :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  # [13, 17] // 13 vacant out of 17 time slots
  def half_hour_time_slots_available
    today = Date.today
    beginning_of_week = today.at_beginning_of_week

    total_week_time_slots = self.time_slots.where(:created_at => beginning_of_week.beginning_of_day..today.at_end_of_week.end_of_day).where(minutes: "30").count

    vacant_week_time_slots = self.time_slots.where(:created_at => beginning_of_week.beginning_of_day..today.at_end_of_week.end_of_day).where(minutes: "30").where(vacancy: true).count
    return [vacant_week_time_slots, total_week_time_slots]
  end

  # if a dietitian accepts an appointment, how many time slots are lost
  def loss_time_slots(appointment)
    taken_time_slot = self.time_slots.where(start_time: appointment.start_time, end_time: appointment.end_time, vacancy: true).first 
    return taken_time_slot.related_time_slots_count
  end

  # if a dietitian accepts an appointment, how many time slots are lost that are the last on the calendar for a time period
  def loss_calendar_slots(appointment)
    loss_cal_slots = []
    taken_time_slot = self.time_slots.where(start_time: appointment.start_time, end_time: appointment.end_time, vacancy: true).first 
    taken_time_slot.related_time_slots.each do |ts|
      if ts.is_last_vacant_time_slot? == true
        loss_cal_slots << ts 
      end
    end
    if taken_time_slot.is_last_vacant_time_slot? == true
      loss_cal_slots << taken_time_slot 
    end
    return loss_cal_slots.count
  end

  def half_hour_time_slots_available
    today = Date.today
    beginning_of_week = today.at_beginning_of_week

    total_week_time_slots = self.time_slots.where(:created_at => beginning_of_week.beginning_of_day..today.at_end_of_week.end_of_day).where(minutes: "30").count

    vacant_week_time_slots = self.time_slots.where(:created_at => beginning_of_week.beginning_of_day..today.at_end_of_week.end_of_day).where(minutes: "30").where(vacancy: true).count
    return [vacant_week_time_slots, total_week_time_slots]
  end

  def main_avatar
    if self.images.count >= 1
      avatar = self.images.where(image_type: "Avatar").where(position: 1)
      if avatar.count >= 1
        return avatar.first.image
      else
        return false
      end
    else
      return false
    end
  end

  def online?
    updated_at > 10.minutes.ago
  end

  def incomplete_recipes
    incomplete_recipes = []
    self.recipes.each do |recipe|
      if recipe.completed == false
        incomplete_recipes << recipe
      end
    end
    return incomplete_recipes
  end


  # override devise without_password model to remove current_password 
  # def update_without_password(params={})
  #   params.delete(:current_password)
  #   super(params)
  # end

end
