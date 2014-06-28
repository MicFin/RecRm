class Ingredient < ActiveRecord::Base

	has_many :ingredients_recipes
	has_many :recipes, through: :ingredients_recipes
	has_and_belongs_to_many :recipe_steps
	
	has_and_belongs_to_many :allergens
end
