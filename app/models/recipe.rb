class Recipe < ActiveRecord::Base
	has_many :ingredients_recipes
	has_many :ingredients, through: :ingredients_recipes
	has_many :recipe_steps
  has_and_belongs_to_many :characteristics
  has_and_belongs_to_many :patient_groups, :uniq => true
  # removed until can utlilize AJAX to render nested forms for recipe form or to submit for ingredients_recipes forms
  # accepts_nested_attributes_for :ingredients_recipes

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

  # return a recipe's intolerance patient groups
  def intolerances
    intolerances=[]
    self.patient_groups.each do |patient_group|
      if patient_group.category.downcase == "intolerance"
        intolerances << patient_group
      end
    end
    return intolerances
  end

  # return a recipe's allergy patient groups
  def allergies
    allergies=[]
    self.patient_groups.each do |patient_group|
      if patient_group.category.downcase == "allergy"
        allergies << patient_group
      end
    end
    return allergies
  end

  # return a recipe's disease patient groups
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


end
