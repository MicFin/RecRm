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

  # returns all Patient Groups with the category allergy except other field
  def self.allergies_no_other
    allergies=[]
    self.all.each do |allergy|
      if allergy.category.downcase == "allergy"
        unless allergy.input_option == true
          allergies << allergy
        end
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

  # returns all Patient Groups with the category intolerance except other field
  def self.intolerances_no_other
    intolerances=[]
    self.all.each do |allergy|
      if allergy.category.downcase == "intolerance"
        unless allergy.input_option == true
          intolerances << allergy
        end
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

  # returns all Patient Groups with the category intolerance except other field
  def self.diseases_no_other
    diseases=[]
    self.all.each do |allergy|
      if allergy.category.downcase == "disease"
        unless allergy.input_option == true
          diseases << allergy
        end
      end
    end
    return diseases
  end

end
