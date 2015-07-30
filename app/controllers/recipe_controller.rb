class RecipeController < ApplicationController
	include CharacteristicsHelper
	include StepsHelper
	include IngredientsHelper

	def show
		
		
		

		# make sure to call this first
		@recipe = Recipe.find(params[:id])

		# ingredients_helper
		get_ingredients!

		# steps_helper
		get_recipe_steps!

		# characteristics_helper
		get_recipe_characteristics!



		@recipe.ingredient_list = @recipe_ingredients
		@recipe.step_list = @recipe_steps
		@recipe.cook_time = @cook_time
		@recipe.prep_time = @prep_time
		@recipe.difficulty = @difficulty
		@recipe.courses = @courses
		@recipe.age_groups = @age_groups
		@recipe.scenarios = @scenarios
		@recipe.holidays = @holidays
		@recipe.cultures = @cultures


	end



	

	private

		# def set_recipe!
		# 	@recipe = Recipe.find(params[:id])
		# end
end
