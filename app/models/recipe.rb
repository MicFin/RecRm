class Recipe < ActiveRecord::Base
	has_many :ingredients_recipes
	has_many :ingredients, through: :ingredients_recipes
	has_many :recipe_steps
  has_and_belongs_to_many :characteristics
end
