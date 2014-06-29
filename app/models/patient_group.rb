class PatientGroup < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_and_belongs_to_many :allergens
  has_and_belongs_to_many :recipes

  # returns all Patient Groups with the category allergy
  def self.allergies
    allergies=[]
    self.all.each do |allergy|
      if allergy.category.downcase == "allergy"
        allergies << allergy
      end
    end
    return allergies
  end

  # returns all Patient Groups with the category intolerance
  def self.intolerances
    intolerances=[]
    self.all.each do |allergy|
      if allergy.category.downcase == "intolerance"
        intolerances << allergy
      end
    end
    return intolerances
  end

  # returns all Patient Groups with the category intolerance
  def self.diseases
    diseases=[]
    self.all.each do |allergy|
      if allergy.category.downcase == "disease"
        diseases << allergy
      end
    end
    return diseases
  end


end
