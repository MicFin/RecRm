class Recipe < ActiveRecord::Base
	has_many :ingredients_recipes
	has_many :ingredients, through: :ingredients_recipes
	has_many :recipe_steps
  has_and_belongs_to_many :characteristics
  # removed until can utlilize AJAX to render nested forms for recipe form or to submit for ingredients_recipes forms
  # accepts_nested_attributes_for :ingredients_recipes

end
