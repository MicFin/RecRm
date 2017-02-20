# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default("")
#  encrypted_password     :string(255)      default("")
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
#  phone_number           :string(255)
#  date_of_birth          :date
#  sex                    :string(255)
#  height_inches          :integer
#  weight_ounces          :integer
#  stripe_id              :text
#  family_note            :text
#  family_role            :string(255)
#  early_access           :boolean          default(FALSE)
#  tara_referral          :boolean          default(FALSE), not null
#  zip_code               :string(255)
#  qol_referral           :boolean          default(FALSE), not null
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  due_date               :datetime
#  registration_stage     :integer          default(0)
#  invitation_token       :string(255)
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  invitations_count      :integer          default(0)
#  time_zone              :string(255)
#  physician_referral     :boolean          default(FALSE)
#  provider               :boolean          default(FALSE)
#  hospitals_or_practices :text
#  academic_affiliations  :text
#  specialty              :string(255)
#  subspecialty           :string(255)
#  fax                    :string(255)
#  terms_accepted         :boolean
#  monologue_user_id      :integer
#

class User < ActiveRecord::Base

  # # ATTRIBUTE ACCESSORS
  attr_accessor :health_group_ids, :health_groups, :image_cache, :remove_image

  # # SCOPES
  # SCOPES: User Type
  # All users with a password
  scope :user_accounts, -> { where("encrypted_password <> ''") }
  # Clients
  scope :client_accounts, -> { user_accounts.where(provider: false)  }

  # Registered Clients
  scope :registered_client_accounts, -> { client_accounts.where(registration_stage: 6)}
  
  # Family members
  scope :family_member_accounts, -> { where("family_role <> ''") }  

  # QOL referral
  scope :qol_referrals_not_accepted, -> { where("confirmation_sent_at IS NOT NULL").where("confirmed_at IS NULL") } 

  # Provider referral
  scope :provider_referrals_not_accepted, -> { where("invitation_sent_at IS NOT NULL").where("invitation_accepted_at IS NULL") } 
  
  # Providers
  scope :provider_accounts, -> { user_accounts.where(provider: true) }
   
  # SCOPES: User Registration Stage
  scope :at_stage, -> (stage){ where(registration_stage: stage) } 
  scope :incomplete_onboarding, -> { where(registration_stage: [1, 2, 3, 4, 5])}
  # SCOPES: Time slot for specific dietitian
  # scope :repeat_customers, -> { includes(:appointment_hosts).where("appointment_hosts.status=?", "Complete").references(:appointment_hosts) }
  # SCOPES: Users by Appointment order
  # scope :order_by_most_current_appointment, -> {includes(:appointment_hosts).order('appoinment_hosts.start_time DESC')}
  scope :order_by_last_sign_in, -> {where("last_sign_in_at IS NOT NULL").order('last_sign_in_at DESC')}
  scope :order_by_created_at, -> {order('created_at DESC')}

  # # ROLIFY
  rolify :role_cname => 'UserRole'

  # # CALL BACKS
  before_save :uppercase_name
  before_save :delete_images, :if => Proc.new {|user| remove_image == "1"}  
  after_save :create_original_growth_entry, :if => Proc.new {|user| user.height_inches_changed? }
  before_save :create_original_food_diary, :if => Proc.new {|user| user.food_diary == nil }
  before_destroy :check_for_appointments

  # A callback event is fired before and after an invitation is accepted (User#accept_invitation!)
  # after_invitation_accepted :email_invited_by
  # before_invitation_accepted :email_invited_by

	# Include default devise modules. Others available are:
	# :lockable, :timeoutable and :omniauthable
	devise :invitable, :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable, :confirmable, :async

  # # RELATIONSHIPS
  has_many :invitations, :class_name => self.to_s, :as => :invited_by
  # If a user is deleted then so should their family connection
  has_many :user_families, :dependent => :destroy
  has_many :families, through: :user_families
  # If a head of family User is deleted then so should the family
  has_many :head_of_families, :class_name => "Family", :foreign_key => "head_of_family_id", dependent: :destroy
  belongs_to :monologue_user, :class_name => "Monologue::User", :foreign_key => "monologue_user_id"
  # If a user is deleted then so should their patient group connections
	has_and_belongs_to_many :patient_groups
  before_destroy { patient_groups.clear }

  has_many :coupon_redemptions, dependent: :destroy
  has_many :coupons, through: :coupon_redemptions
  
  has_many :user_packages, dependent: :destroy
  # has_many :packages, through: :user_packages

  has_many :purchases

	has_many :appointments
  has_many :patient_focus, :class_name => "Appointment", :foreign_key => "patient_focus_id"
  has_many :appointment_hosts, :class_name => "Appointment", :foreign_key => "appointment_host_id"
  has_many :rooms
  has_many :subscriptions, dependent: :destroy
  has_many :member_plans, through: :subscriptions


  has_one :growth_chart, dependent: :destroy # user is deleted then delete their growth chart 
  has_one :food_diary, dependent: :destroy # user is deleted then delete their food diary 

  has_many :post_recommendations
  
  has_many :images, :as => :imageable, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true

  ### wanted to have a user have many surveys but then also haev a user be surveyable but it looks strange and may act weird so didnt implement yet
  has_many :surveys, dependent: :destroy # user is deleted then delete their surveys 
  has_many :surveys, :as => :surveyable, dependent: :destroy # user is deleted then delete their surveys 
  
  # saves phone number in normalized US format
  phony_normalize :phone_number, :default_country_code => 'US'

  # validates phone number is in a correct format
  validates :phone_number, :phony_plausible => true

  # validates timezone is created
  # allows nil if no time zone is saved
  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map.keys, :allow_blank => true

  # versioning and tracking of model changes
  has_paper_trail

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

  # Gets a users appointment registration stage or self registration stage if first time
  # creates an apointment for registration
  # bloated method and shoudlnt be on the user
  # important method for now
  def appointment_registration_stage


    repeat_customer_boolean = self.repeat_customer?

    # if a repeat customer then default the patient focus to their last appointment's patient focus
    if repeat_customer_boolean 
      previous_patient_focus_id = self.appointment_hosts.complete_or_scheduled.last.patient_focus.id 
    else
      previous_patient_focus_id = nil
    end

    # set appointment or create a new one
    # appointment registration stage should start at 5 for appointments
    appointment = self.appointment_in_registration || Appointment.create(appointment_host_id: self.id, status: "In Registration", registration_stage: 5, duration: 60, patient_focus_id: previous_patient_focus_id)

    # If user is a repeat customer then
    if repeat_customer_boolean
      # change stage of registration to the appointment registration stage
      stage_of_registration = appointment.registration_stage
    # If not a repeat customer then 
    else
      # Set stage of registration to user's registration stage
      stage_of_registration = self.registration_stage
    end 

    return stage_of_registration
  end

  # return the user's appointment currently in registration or returns nil
  def appointment_in_registration
    return self.appointment_hosts.unscheduled.last || nil
  end

  # returns true if user is a repeat customer
  def repeat_customer?
    if self.appointment_hosts.complete.size >= 1 || self.appointment_hosts.paid.size >= 1 || self.registration_stage >= 6
      return true
    else
      return false
    end
  end

def health_groups_by_category
  groups = self.patient_groups
  groups_by_category = {
    diseases: [], 
    allergies: [],
    symptoms: [],
    preferences: []
  }
  groups.each do |group|
    if (group.category == "diet")
      groups_by_category[:preferences] << group
    elsif (group.category == "disease")
      groups_by_category[:diseases] << group
    elsif (group.category == "allergy" || group.category == "intolerance")
      groups_by_category[:allergies] << group
    else
      groups_by_category[:symptoms] << group
    end

  end
  return groups_by_category
end

  # returns an array of patient groups for a user that are type disease, allergy, or intolerance
  def get_nutrition_ids
    nutrition_ids = []
    self.patient_groups.each do |group|
      if (group.category == "disease") || (group.category == "allergy") || (group.category == "intolerance")
        nutrition_ids << group.id
      end
    end
    return nutrition_ids
  end

  # returns an array of patient groups for a user that are diets or symptoms
  def get_preferences_ids

    preferences_ids =[]
    self.patient_groups.each do |group|
      if (group.category == "symptom") || (group.category == "diet")
        preferences_ids << group.id
      end
    end
    return preferences_ids
  end

    # Called in
  # - registrations#check_registration_stage
  # Parameter(s)
  # - none
  # Return Value(s)
  # - "0"
  # - "1"
  def update_registration_stage
    
    # if the user has a paid or follow up unpaid appointment then mark as regsitration stage of 6 
    if (self.appointment_hosts.scheduled.count >= 1) 
      self.registration_stage = 6

    else

      # Stage 0 - user has not confirmed account
      if self.confirmation_required? && !self.confirmed?
        self.registration_stage = 0

      # Stage 1 - user did not complete account set up
      elsif !self.phone_number
        self.registration_stage = 1

      # Stage 2 - user created account but did not create family
      elsif self.head_of_families.length < 1 
        self.registration_stage =  2

      # Stage 3 - user created family but did not save health groups
      
      # Stage 4 - user saved health groups but did not save diet

      # Stage 5 - user created but did not pay for appointment
      # elsif self.appointment_hosts.length >= 1
        
      else 
        # return 4
      end
    end
    save
    # done
  end

  # Called in
  # - applications#after_sign_in_path_for
  # Parameter(s)
  # - none
  # Return Value(s)
  # - true
  # - false

  def finished_on_boarding?
    # user is finished with on boarding when they are at a registration stage of 6
    if self.registration_stage == 6
      return true
    else
      return false 
    end
  end

  def unverified_health_groups
    unverified_groups = {
      "disease" => [],
      "intolerance" => [],
      "allergy"=> [],
      "symptom"=> [],
      "diet"=> [],
    }
    self.patient_groups.unverified.each do |group|
        if group.category.downcase == "disease"
          unverified_groups["disease"] << group
        elsif group.category.downcase == "intolerance"
          unverified_groups["intolerance"] << group
        elsif group.category.downcase == "allergy"
          unverified_groups["allergy"] << group
        elsif group.category.downcase == "symptom"
          unverified_groups["symptom"] << group
        elsif group.category.downcase == "diet"
          unverified_groups["diet"] << group
        else
          # nothing
        end
    end
    return unverified_groups
  end
    
  # returns height_hash = {'feet'=> ##, 'inches' => ##}
  def height_hash
    height_hash = {}
    if self.height_inches
      feet = self.height_inches / 12
      inches = self.height_inches % 12
      height_hash["feet"] = feet
      height_hash["inches"] = inches
    else
      height_hash["feet"] = nil
      height_hash["inches"] = nil
    end

    return height_hash
  end

    # returns weight_hash = {'pounds'=> ##, 'ounces' => ##}
  def weight_hash
    weight_hash = {}
    if self.weight_ounces
      pounds = self.weight_ounces / 16
      ounces = self.weight_ounces % 16
      weight_hash["pounds"] = pounds
      weight_hash["ounces"] = ounces
    else
      weight_hash["pounds"] = nil
      weight_hash["ounces"] = nil
    end

    return weight_hash
  end

  # Checks whether a password is needed or not. For validations only.
  def password_required?
    
    # Password is required if it is being set, but not for new records
    # if !persisted? 
    #   false
    # else
    #   !password.nil? || !password_confirmation.nil?
    # end
    false
  end

  def email_required?
    
    # user = self
    # if user.has_role? "Family Member Account"
    #   return false
    # else
    #   return true
    # end
    false
  end

  def uppercase_name

    if first_name && last_name 
      self.first_name.capitalize!
      self.last_name.capitalize!

    elsif first_name
      self.first_name.capitalize!

    else
      return true
    end
  end

  # only require confirmation for qol referrals
  def confirmation_required?
    # if a QOL referral does not have a password then require confirmation email because the user was created by QOL admin OR is physician referral
    
    if (self.qol_referral && self.encrypted_password.blank?) || self.physician_referral
      return true

    # else if not a QOL referral or QOL referral has a password 
    else
      return false
    end
  end

  # new function to set the password without knowing the current password used in our confirmation controller. 
  def attempt_set_password(params)
    
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end

  # new function to return whether a password has been set
  def has_no_password?
    
    self.encrypted_password.blank?
  end

  # new function to provide access to protected method unless_confirmed
  def only_if_unconfirmed
    
    pending_any_confirmation {yield}
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end
  
  private

  def delete_images
    self.images = []
  end


  def create_original_growth_entry
    growth_chart = self.growth_chart || GrowthChart.create(user_id: self.id)
    if growth_chart.growth_entries.count < 1 
      GrowthEntry.create({growth_chart_id: growth_chart.id, height_in_inches: self.height_inches, weight_in_ounces: self.weight_ounces, measured_at: Date.today})
    end
  end

  def create_original_food_diary
    self.food_diary = FoodDiary.new
  end

  def check_for_appointments
    # do no delete if user is a patient focus of at stage 5 of an appointment
    if ( (self.patient_focus.count >= 1) || ( ( self.appointment_hosts.count >= 1) && (self.registration_stage >= 5) ) )
      errors[:messages] << "Can not delete family member's that have appointments assigned to them."
      return false
    end

  end

end
