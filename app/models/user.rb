class User < ActiveRecord::Base
  rolify :role_cname => 'UserRole'

  before_save :uppercase_name
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable




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

  def sign_up_stage
    
    if self.appointment_hosts.where(status: "In Registration").count >= 1
      
      return self.appointment_hosts.where(status: "In Registration").last.stage 
    else
      return 1
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
  # Passwords are always required if it's a new record, or if the password
  # or confirmation are being set somewhere 
  def password_required?
    # user = self
    # if user.has_role? "Family Member Account"
    #   return false
    # else
    #   !persisted? || !password.nil? || !password_confirmation.nil?
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
          final_age = age.to_s + " years and "+ months.to_s +" months old"
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


end
