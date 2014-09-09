class RecipeStep < ActiveRecord::Base
	attr_accessor :ingredient_list

	belongs_to :recipe
	has_and_belongs_to_many :ingredients_recipes
end
