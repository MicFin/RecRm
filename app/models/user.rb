class User < ActiveRecord::Base
  resourcify
  rolify

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

  # saves phone number in normalized US format
  phony_normalize :phone_number, :default_country_code => 'US'

  # validates phone number is in a correct format
  validates :phone_number, :phony_plausible => true

  def singular_possessive
    if self.sex == "Male"
      return "his"
    elsif self.sex == "Female"
      return "her"
    end
  end

  def password_required?
    ### until roles are created to define what needs validation, the password and email requirements are handled on the front end with JS so that child users can be created by main users without needing to add a password or email to the child
    # if user roll x then
    # !persisted? || !password.nil? || !password_confirmation.nil?
    # else
    false
    # end
  end

  def email_required?
    # ## if user roll x then 
    # true
    ## else
    false
    # end
  end

  def uppercase_name
    self.first_name.capitalize!
    self.last_name.capitalize!
  end

  def age
    age = DateTime.now.year - self.birth_date.year
    return age
  end
  
  def height
    feet = self.height_inches / 12
    inches = self.height_inches % 12
    if feet <= 0
      return "#{inches} inches"
    elsif inches > 0
      return "#{feet}ft #{inches}in"
    else
      return "#{feet}ft"
    end
  end

  def weight
    pounds = self.weight_ounces / 16
    ounces = self.weight_ounces % 16
    if pounds <= 0
      return "#{ounces} ounces"
    elsif ounces > 0
      return "#{pounds} pounds #{ounces} ounces"
    else
      return "#{pounds} pounds"
    end
  end
end
