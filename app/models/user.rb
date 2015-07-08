class User < ActiveRecord::Base
  rolify :role_cname => 'UserRole'

  before_save :uppercase_name
	# Include default devise modules. Others available are:
	# :lockable, :timeoutable and :omniauthable, :invitable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable,:confirmable



  has_many :user_families
  has_many :families, through: :user_families
  has_many :head_of_families, :class_name => "Family", :foreign_key => "head_of_family_id"
	has_and_belongs_to_many :patient_groups
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


  # Called in
  # - registrations#check_registration_stage
  # Parameter(s)
  # - none
  # Return Value(s)
  # - "0"
  # - "1"

  def registration_stage
    # Stage 0 - user has not confirmed account
    if !self.confirmed? 
      return 0
    # Stage 1 - user confirmed but did not complete account set up
    elsif !self.phone_number
      return 1
    # Stage 2 - user did not create family
    elsif self.head_of_families.length < 1 
      return 2
    # Stage 3 - user did not set up appointment
    elsif self.appointment_hosts.length < 1
      return 3
    else 
      return 4
    end
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
    # user is finished with on boarding when they are at a registration stage of 3
    if self.registration_stage == 4
      return true
    else
      return false 
    end
  end

  def unverified_health_groups
    unverified_array = []
    self.patient_groups.each do |group|
      if group.unverified == true 
        unverified_array << group
      end
    end
    return unverified_array
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

  def age
    ### months up to 2 years + months
    dob = self.date_of_birth
    # if a date of birth is on file
    if dob != nil 
      now = Time.now.utc.to_date
      # age is (today's year - birthday year) 
      # if today's month is greater than dob month or same month but day is greater or equal to then subract
      # if born on Jan 5 2000 and it is Jan 5 2015 then age = 15 
      # if born on Jan 5 2000 and it is Jan 6 2015 then age = 14
      # if born on Jan 6 2000 and it is Jan 5 2015 then age = 15
      age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
      # for under 1 year old
      if age < 1
        age = now.month - dob.month
        if age > 1
          final_age = age.to_s + " months old"
        else 
          final_age = age.to_s + " month old"
        end
      # for between 1 and 2 year olds
      elsif (age >= 1 ) && (age <= 2)
        months = now.month - dob.month
        final_age = (24 + months).to_s + " months old"
      # for 3 and older
      else
        months = now.month - dob.month
        if months == 1
          final_age = age.to_s + " years and 1 month old"
        elsif months > 1
          final_age = age.to_s + " years and " + months.to_s + " months old"
        else
          final_age = age.to_s + " years old"
        end
      end
      return final_age
    else
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
        return "#{ounces} ounces"
      elsif ounces > 0
        return "#{pounds} pounds #{ounces} ounces (#{kilograms} kg)"
      else
        return "#{pounds} pounds (#{kilograms} kg)"
      end
    else
      return "Not entered"
    end
  end

  # use to change if confirmation is required or not
  # def confirmation_required?
  #   
  #   true
  # end

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
