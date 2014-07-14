module RecipesHelper

	def get_recipe_list!(type)
		@unfiltered_recipes = Recipe.all
		if type == "family"
			ingredient_ids = @family_ingredients.collect(&:id)
		else
			ingredient_ids = @user_ingredients.collect(&:id)
		end

		ingredient_ids = @user_ingredients.collect(&:id)
		@filtered_recipes = []

		@unfiltered_recipes.map do | recipe |
			recipe_ingredients_list = recipe.ingredients

			#Check if recipe includes bad ingredients
		    match = recipe_ingredients_list.where.not(id: ingredient_ids).pluck(:id)

		    # Filtered Recipes with ingredients, images, steps and other details
			if !match.empty?
				recipe.ingredient_list = recipe_ingredients_list
				recipe.step_list = recipe.recipe_steps
				recipe.characteristic_list = recipe.characteristics
				@filtered_recipes << recipe 
			end
		end

		#Rable tutorial https://github.com/nesquena/rabl
		gon.rabl as: 'filtered_recipes'

	end

	def get_recipe!
	end
end
