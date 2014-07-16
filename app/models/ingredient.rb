class Ingredient < ActiveRecord::Base

	has_many :ingredients_recipes
	has_many :recipes, through: :ingredients_recipes
	has_and_belongs_to_many :recipe_steps
	has_and_belongs_to_many :allergens, :uniq => true
  has_many :quality_reviews, as: :quality_reviewable 
  # method to check if an ingredient has had allergens added
  def need_allergens?
    # if an ingredient has allergens already
    if self.allergens.count >= 1
      return false
    # if no allergens have been attached yet
    else
      return true
    end
  end
  
  # returns ingredient allergens that are not in the top 10 or self
  def other_allergens
    other_allergens = self.allergens
    main_allergens = Allergen.first(10)
    other_allergens = other_allergens - main_allergens
    other_allergens = other_allergens - Allergen.where(name: self.name)
    return other_allergens
  end

end
