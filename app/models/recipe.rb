class Recipe < ActiveRecord::Base
  attr_accessor :ingredient_list
  attr_accessor :step_list
  attr_accessor :characteristic_list
  attr_accessor :courses
  attr_accessor :age_groups
  attr_accessor :scenarios
  attr_accessor :holidays
  attr_accessor :cultures

	has_many :ingredients_recipes
	has_many :ingredients, through: :ingredients_recipes
	has_many :recipe_steps
  has_and_belongs_to_many :characteristics, :uniq => true
  has_and_belongs_to_many :patient_groups, :uniq => true
  belongs_to :dietitian
  validates :name, :presence => {:message => 'cannot be blank, Recipe not saved'}
  # paperclip loaded image 
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  do_not_validate_attachment_file_type :avatar
  # validate :has_mandatory_characteristics
  # removed until can utlilize AJAX to render nested forms for recipe form or to submit for ingredients_recipes forms
  # accepts_nested_attributes_for :ingredients_recipes
  # quality reviews polymoprhic
  has_many :quality_reviews, as: :quality_reviewable 
  has_many :marketing_items, as: :marketing_itemable 
  has_many :quality_reviews
  has_many :review_conflicts, through: :quality_reviews
 
  # returns recipe ingredients in order
  def ordered_ingredients
    self.ingredients_recipes.sort_by(&:position)
  end


  # returns recipe steps in order
  def steps
    self.recipe_steps.sort_by(&:position)
  end

  # return hash of recipe marketing items by patient group and by title ad description
  def marketing_items_by_group
    items_by_group = {}
    self.marketing_items.each do |marketing_item|
      if marketing_item.patient_group_id == nil 
        group = "General"
        group_id = 0
      else
        group_id = marketing_item.patient_group_id
        group = PatientGroup.find(group_id).name
      end
      if (items_by_group.has_key?(group) == false)
        items_by_group[group] = {"group_id" => group_id}
        items_by_group[group]["items"] = {}
      end
      if marketing_item.category == "title"
        items_by_group[group]["items"]["title"] = marketing_item
      elsif marketing_item.category == "description"
        items_by_group[group]["items"]["description"] = marketing_item
      end 
    end
    return items_by_group
  end
  # return an array of all unique recipe titles
  def self.all_recipe_names
    return self.all.map(&:name).uniq
  end
  # return a recipe's ingredients that have already been tagged with allergens
  def ingredients_tagged
    tagged_ingredients = []
    self.ingredients.each do |ingredient|
      if ingredient.need_allergens? == false
        tagged_ingredients << ingredient
      end
    end
    return tagged_ingredients
  end

  # return a recipe's ingredients that have not yet been tagged with allergens
  def ingredients_not_tagged
    not_tagged_ingredients = []
    self.ingredients.each do |ingredient|
      if ingredient.need_allergens? == true 
        not_tagged_ingredients << ingredient
      end
    end
    return not_tagged_ingredients
  end

  # return a recipe's Patient Groups with the category intolerance
  def intolerances
    intolerances=[]
    self.patient_groups.each do |patient_group|
      if patient_group.category.downcase == "intolerance"
        intolerances << patient_group
      end
    end
    return intolerances
  end

  # return a recipe's PAtient Groups with the category allergy
  def allergies
    allergies=[]
    self.patient_groups.each do |patient_group|
      if patient_group.category.downcase == "allergy"
        allergies << patient_group
      end
    end
    return allergies
  end

  # return a recipe's Patient Groups with the category disease
  def diseases
    diseases=[]
    self.patient_groups.each do |patient_group|
      if patient_group.category.downcase == "disease"
        diseases << patient_group
      end
    end
    return diseases
  end

  # return a recipe's allergens, used in recipes controller edit_recipe_group method to only show patient groups that are safe based on ingredient list when selecting recipe's patient groups
  def allergens
    allergens=[]
    self.ingredients.each do |ingredient|
      ingredient.allergens.each do |allergen|
        allergens << allergen
      end
    end
    return allergens.uniq
  end

  # return recipes that are made for patient groups entered as an array of strings
  def self.made_for(*patient_groups)
    num_groups = patient_groups.count
    arrays = Array.new(num_groups) { [] }

    patient_groups.each_with_index do |patient_group, index|
        arrays[index] << Recipe.includes(:patient_groups).where('patient_groups.name = ?', patient_group).references(:patient_group)
    end
    made_for_array = []
    for i in 0...num_groups
      if made_for_array != []
        made_for_array.flatten!
        made_for_array = arrays[i].flatten & made_for_array
      else
        made_for_array = arrays[i].flatten
      end
    end
    return made_for_array
  end
  # def has_mandatory_characteristics
  #   binding.pry
  # end

end
