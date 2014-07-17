module IngredientsHelper


	def get_ingredients!
		ingredients = @recipe.ingredients
		recipe_id = @recipe.id
		@recipe_ingredients = []

		ingredients.map do | ingredient |
			characteristic_list = ingredient.ingredients_recipes.where(recipe_id: recipe_id).first
			ingredient.ingredient_characteristics = characteristic_list 

			@recipe_ingredients << ingredient
		end

	end


end
