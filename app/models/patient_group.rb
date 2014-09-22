class PatientGroup < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_and_belongs_to_many :allergens
  has_and_belongs_to_many :recipes
  has_and_belongs_to_many :articles
  has_many :marketing_items


  # returns all Patient Groups with the category allergy and a Patient Group named "Other Allergy" with an input field true boolean
  def self.allergies_with_other
    allergies=[]
    self.all.each do |allergy|
      if allergy.category.downcase == "allergy"
        allergies << allergy
      end
    end
    return allergies
  end

  # returns all Patient Groups with the category allergy 
  def self.allergies
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

  # returns all Patient Groups with the category intolerance and a Patient Group named "Other Intolerance" with an input field true boolean
  def self.intolerances_with_other
    intolerances=[]
    self.all.each do |allergy|
      if allergy.category.downcase == "intolerance"
        intolerances << allergy
      end
    end
    return intolerances
  end

  # returns all Patient Groups with the category intolerance 
  def self.intolerances
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

  # returns array of all Patient Groups with the category disease and an Patient Group named "Other Disease" with an input field true boolean
  def self.diseases_with_other_field
    diseases=[]
    self.all.each do |allergy|
      if allergy.category.downcase == "disease"
        diseases << allergy
      end
    end
    return diseases
  end

  # returns all Patient Groups with the category intolerance except other field
  def self.diseases
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


  # Returns an array of Patient Groups with the category "allergy" that are safe for the input array of allergens
  def self.safe_allergy_groups(array_of_recipes_allergens)
    safe_patient_groups = []
    safe_allergy_groups = []
    self.all.each do |patient_group|
      if patient_group.allergens.count < 1
        safe_patient_groups << patient_group  
      end 
      patient_group.allergens.each do |allergen|
        if array_of_recipes_allergens.include?(allergen)
        else
          safe_patient_groups << patient_group 
        end
      end    
    end  
    safe_patient_groups.each do |patient_group|
      if patient_group.category.downcase == "allergy"
          safe_allergy_groups << patient_group
      end
    end
    safe_allergy_groups.delete(PatientGroup.where(name: "Other Allergy").first)
    return safe_allergy_groups
  end

  # Returns an array of Patient Groups with the category "intolerances" that are safe for the input array of allergens
  def self.safe_intolerance_groups(array_of_recipes_allergens)
    safe_patient_groups = []
    safe_intolerance_groups = []
    self.all.each do |patient_group|
      if patient_group.allergens.count < 1
        safe_patient_groups << patient_group  
      end 
      patient_group.allergens.each do |allergen|
        unless array_of_recipes_allergens.include?(allergen)
          safe_patient_groups << patient_group 
        end
      end
    end 
    safe_patient_groups.each do |patient_group|
      if patient_group.category.downcase == "intolerance"
          safe_intolerance_groups << patient_group
       end
    end
    safe_intolerance_groups.delete(PatientGroup.where(name: "Other Intolerance").first)
    return safe_intolerance_groups
  end

  # Returns an array of Patient Groups with the category "disease" that are safe for the input array of allergens
  def self.safe_disease_groups(array_of_recipes_allergens)
    safe_patient_groups = []
    safe_disease_groups = []
    self.all.each do |patient_group|
      if patient_group.allergens.count < 1
        safe_patient_groups << patient_group  
      end 
      patient_group.allergens.each do |allergen|
        unless array_of_recipes_allergens.include?(allergen)
          safe_patient_groups << patient_group 
        end
      end
    end  
    safe_patient_groups.each do |patient_group|
      if patient_group.category.downcase == "disease"
          safe_disease_groups << patient_group
       end
    end
    safe_disease_groups.delete(PatientGroup.where(name: "Other Disease").first)
    return safe_disease_groups
  end

end
