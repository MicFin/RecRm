# == Schema Information
#
# Table name: dietitians
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string(255)
#  last_name              :string(255)
#  signature              :string(255)
#  time_zone              :string(255)
#

class Dietitian < ActiveRecord::Base
  attr_accessor :current_password, :image_cache, :remove_image

  rolify :role_cname => 'Role'
  scope :online, lambda{ where("updated_at > ?", 10.minutes.ago) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :async
         
  has_many :appointments
  has_many :availabilities
  has_many :time_slots, through: :availabilities
  has_many :post_recommendations
  has_many :images, :as => :imageable, dependent: :destroy
  has_many :expertises 
  has_many :patient_groups, through: :expertises

  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :expertises

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

  private

  # override devise without_password model to remove current_password 
  # def update_without_password(params={})
  #   params.delete(:current_password)
  #   super(params)
  # end

end
