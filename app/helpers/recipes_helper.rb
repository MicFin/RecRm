module RecipesHelper

	def get_recipe_list!(type)
		recipes = Recipe.all
		if type == "family"
			ingredient_ids = @family_ingredients.collect(&:id)
		else
			ingredient_ids = @user_ingredients.collect(&:id)
		end

		ingredient_ids = @user_ingredients.collect(&:id)
		@recipe_list = []

		recipes.map do | recipe |
			array = recipe.ingredients
		        match = array.where.not(id: ingredient_ids).pluck(:id)
			if !match.empty?
				@recipe_list << recipe 
			end
		end
		gon.recipe_list = @recipe_list
		#Rails.logger.debug("MY RECIPES: #{@recipe_list}")
	end

	def get_recipe!
	end
end
