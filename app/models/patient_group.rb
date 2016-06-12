# == Schema Information
#
# Table name: patient_groups
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  category     :string(255)
#  description  :text
#  order        :integer
#  input_option :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  unverified   :boolean          default(FALSE)
#  has_triggers :boolean          default(FALSE), not null
#

class PatientGroup < ActiveRecord::Base

  # # SCOPES
  # Patient group verification
  scope :unverified, -> { where(unverified: true) } 
  scope :verified, -> { where(unverified: false) } 
  # Patient group category
  scope :allergy, -> { where(category: "allergy") } 
  scope :intolerance, -> { where(category: "intolerance") } 
  scope :disease, -> { where(category: "disease") } 
  scope :symptom, -> { where(category: "symptom") } 
  scope :diet, -> { where(category: "diet") } 
  # Input option for adding your own
  scope :exclude_add_another, -> { where(input_option: false) } 
  # Order
  scope :in_order, -> { order(order: :asc) }

  # # RELATIONSHIPS
	has_and_belongs_to_many :users
  has_many :expertises 
  has_many :dietitians, through: :expertises

  # # CLASS METHODS
  
  # returns all Patient Groups with the category allergy and a Patient Group named "Other Allergy" with an input field true boolean
  def self.allergies_with_other
    self.verified.allergy.in_order
  end

  # returns all Patient Groups with the category allergy 
  def self.allergies
    self.verified.allergy.exclude_add_another.in_order
  end

  # returns all Patient Groups with the category intolerance and a Patient Group named "Other Intolerance" with an input field true boolean
  def self.intolerances_with_other
    self.verified.intolerance.in_order
  end

  # returns all Patient Groups with the category intolerance 
  def self.intolerances
    self.verified.intolerance.exclude_add_another.in_order
  end

  # returns array of all Patient Groups with the category disease and an Patient Group named "Other Disease" with an input field true boolean
  def self.diseases_with_other
    self.verified.disease.in_order
  end

  # returns all Patient Groups with the category intolerance except other field
  def self.diseases
    self.verified.disease.exclude_add_another.in_order
  end

  def self.symptoms
    self.verified.symptom.exclude_add_another.in_order
  end

  def self.diets
    self.verified.diet.exclude_add_another.in_order
  end

end
