class RecipeController < ApplicationController
	include CharacteristicsHelper
	include StepsHelper

	def show
		
		
		

		# make sure to call this first
		@recipe = Recipe.find(params[:id])

		# characteristics_helper
		get_recipe_characteristics!

		# steps_helper
		get_recipe_steps!

		@recipe.ingredient_list = @recipe.ingredients
		@recipe.step_list = @recipe_steps
		@recipe.cook_time = @cook_time
		@recipe.prep_time = @prep_time
		@recipe.difficulty = @difficulty
		@recipe.courses = @courses
		@recipe.age_groups = @age_groups
		@recipe.scenarios = @scenarios
		@recipe.holidays = @holidays
		@recipe.cultures = @cultures

		gon.rabl as: 'recipe'

	end



	

	private

		# def set_recipe!
		# 	@recipe = Recipe.find(params[:id])
		# end
end
