class Ingredient < ActiveRecord::Base

	has_many :ingredients_recipes
	has_many :recipes, through: :ingredients_recipes
	has_and_belongs_to_many :recipe_steps
	has_and_belongs_to_many :allergens
	has_and_belongs_to_many :characteristics
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
  
end
