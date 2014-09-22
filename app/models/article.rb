class Article < ActiveRecord::Base
  belongs_to :dietitian
  has_and_belongs_to_many :characteristics
  has_and_belongs_to_many :patient_groups
  has_many :marketing_items, as: :marketing_itemable 


  #### these 3 methods are the same for the recipe model as well.  Maybe recipe and article should inherit from a "content" class or module ###

  # return a article's Patient Groups with the category intolerance
  def intolerances
    intolerances=[]
    self.patient_groups.each do |patient_group|
      if patient_group.category.downcase == "intolerance"
        intolerances << patient_group
      end
    end
    return intolerances
  end

  # return a article's PAtient Groups with  category allergy
  def allergies
    allergies=[]
    self.patient_groups.each do |patient_group|
      if patient_group.category.downcase == "allergy"
        allergies << patient_group
      end
    end
    return allergies
  end

  # return a article's Patient Groups with the category disease
  def diseases
    diseases=[]
    self.patient_groups.each do |patient_group|
      if patient_group.category.downcase == "disease"
        diseases << patient_group
      end
    end
    return diseases
  end


end
