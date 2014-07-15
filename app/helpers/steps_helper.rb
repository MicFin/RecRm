module StepsHelper

	def get_recipe_steps!
	steps = @recipe.recipe_steps
	@recipe_steps = []

		steps.map do | step |
			step_ingredients_list = step.ingredients
			step.ingredient_list = step_ingredients_list
			@recipe_steps << step
		end

	end

	def do_somthing!
	end
end
