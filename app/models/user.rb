class User < ActiveRecord::Base

  attr_accessor :health_group_ids
  attr_accessor :health_groups
  # used for form in families/new

  rolify :role_cname => 'UserRole'

  before_save :uppercase_name

	# Include default devise modules. Others available are:
	# :lockable, :timeoutable and :omniauthable, :invitable
	devise :invitable, :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable, :confirmable


  # If a user is deleted then so should their family connection
  has_many :user_families, :dependent => :destroy
  has_many :families, through: :user_families

  has_many :head_of_families, :class_name => "Family", :foreign_key => "head_of_family_id"

  # If a user is deleted then so should their patient group connections
	has_and_belongs_to_many :patient_groups
  before_destroy { patient_groups.clear }

	has_many :appointments
  has_many :patient_focus, :class_name => "Appointment", :foreign_key => "patient_focus_id"
  has_many :appointment_hosts, :class_name => "Appointment", :foreign_key => "appointment_host_id"
  has_many :rooms
  has_many :subscriptions
  has_many :member_plans, through: :subscriptions
  has_many :surveys
    ### wanted to have a user have many surveys but then also haev a user be surveyable but it looks strange and may act weird so didnt implement yet
  has_many :surveys, :as => :surveyable
  
  # saves phone number in normalized US format
  phony_normalize :phone_number, :default_country_code => 'US'

  # validates phone number is in a correct format
  validates :phone_number, :phony_plausible => true

  # validates timezone is created
  # allows nil if no time zone is saved
  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map.keys, :allow_blank => true

  # return the user's appointment currently in registration or returns nil
  def appointment_in_registration
    return self.appointment_hosts.where(status: "In Registration").last || nil
  end

  # returns true if user is a repeat customer
  def repeat_customer?
    return self.appointment_hosts.where(status: "Paid").count >= 1
  end

  # returns an array of patient groups for a user 
  def get_patient_group_ids
     patient_group_ids = self.patient_groups.map{|disease|disease.id}
     return patient_group_ids
  end

  # returns an array of patient groups for a user that are type disease
  def get_disease_ids
     diseases = self.patient_groups & PatientGroup.diseases
     disease_ids = diseases.map{|disease|disease.id}
     return disease_ids
  end

  # returns an array of patient groups for a user that are diets or symptoms
  def get_preferences_ids
    groups = self.patient_groups
    symptoms = groups & PatientGroup.symptoms
    diets = groups & PatientGroup.diets
    preferences = diets + symptoms
    
    preferences_ids = preferences.flatten.map{|disease|disease.id}
    
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
    if (self.appointment_hosts.where(status: "Paid").count >= 1 || self.appointment_hosts.where(status: "Follow Up Unpaid").count >= 1) 
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
      "diseases" => [],
      "intolerances" => [],
      "allergies"=> [],
      "symptoms"=> [],
      "diets"=> [],
    }
    binding.pry
    self.patient_groups.each do |group|
      if group.unverified == true 
        if group.category.downcase == "diseases"
          unverified_groups["diseases"] << group
        elsif group.category.downcase == "intolerances"
          unverified_groups["intolerances"] << group
        elsif group.category.downcase == "allergies"
          unverified_groups["allergies"] << group
        elsif group.category.downcase == "symptoms"
          unverified_groups["symptoms"] << group
        elsif group.category.downcase == "diets"
          unverified_groups["diets"] << group
        else
          # nothing
        end
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


  def singular_possessive
    if self.sex == "Male"
      return "his"
    elsif self.sex == "Female"
      return "her"
    end
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
    if first_name || last_name 
      self.first_name.capitalize!
      self.last_name.capitalize!
    else
      return true
    end
  end

  def full_name
    return "#{first_name} #{last_name}" 
  end

  def age
    ### shown in months up to 2 years + 11 months
    dob = self.date_of_birth

    # if a date of birth is on file
    if dob != nil 

      now = Date.current
      
      # get the number of full years from now since birth by dividing the difference in days by 365
      years = (now - dob).to_i / 365

      # for under 3 year olds return in terms of months
      if years < 3
        months = now.month - dob.month
        if years == 0
          if months > 1
            final_age = months.to_s + " months old"
          else 
            final_age = months.to_s + " month old"
          end
        elsif years == 1
          if months > 1
            final_age = years.to_s + " year and " + months.to_s + " months old"
          else 
            final_age = years.to_s + " year and " + months.to_s + " month old"
          end
        else
          if months > 1
            final_age = years.to_s + " years and " + months.to_s + " months old"
          else 
            final_age = years.to_s + " years and " + months.to_s + " month old"
          end  
        end

      # for older than 3 return in terms of years and months
      else
        months = now.month - dob.month
        if months == 1
          final_age = years.to_s + " years and 1 month old"
        elsif months > 1
          final_age = years.to_s + " years and " + months.to_s + " months old"
        else
          final_age = years.to_s + " years old"
        end
      end
      return final_age
    else
      # change nil to "No Date of Birth"
      return nil
    end
  end
  
  def height
    if (height_inches != nil )
      feet = self.height_inches / 12
      inches = self.height_inches % 12
      if feet <= 0
        centimeters = (inches * 2.54).round(2)
        return "#{inches} inches (#{centimeters} cm)"
      elsif inches > 0
        centimeters = (((feet * 12) + inches) * 2.54).round(2)
        return "#{feet} feet #{inches} inches (#{centimeters} cm)"
      else
        centimeters = ((feet * 12) * 2.54).round(2)
        return "#{feet} feet (#{centimeters} cm)"
      end
    else
      return "Not entered"
    end
  end

  def weight
    if (weight_ounces != nil )
      kilograms = (weight_ounces * 0.0283495).round(2)
      pounds = self.weight_ounces / 16
      ounces = self.weight_ounces % 16
      if pounds <= 0
        return "#{ounces} ounces (#{kilograms} kg)"
      elsif ounces > 0
        return "#{pounds} pounds #{ounces} ounces (#{kilograms} kg)"
      else
        return "#{pounds} pounds (#{kilograms} kg)"
      end
    else
      return "Not entered"
    end
  end

  # only require confirmation for qol referrals
  def confirmation_required?
    # if a QOL referral does not have a password then require confirmation email because the user was created by QOL admin
    if self.qol_referral && self.encrypted_password.blank?
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
  

end
