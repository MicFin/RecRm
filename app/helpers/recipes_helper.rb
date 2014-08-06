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

	def get_recipe_list_by_groups!(*groups)
		@unfiltered_recipes = Recipe.all
		@group_allergens = []
		new_groups = []
		groups.map do |group|
			new_groups << PatientGroup.where(name: group).first
		end
		new_groups.map do | patient_group |
			array = patient_group.allergens
			@group_allergens += array
		end
		@group_allergens = @group_allergens.uniq.sort_by{|a| a.name.downcase}
		@group_ingredients = []
		@group_allergens.map do | allergen |
			array = allergen.ingredients
			@group_ingredients += array
		end
		@group_ingredients = @group_ingredients.uniq.sort_by{|a| a.name.downcase}
		ingredient_ids = @group_ingredients.collect(&:id)
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
		return @filtered_recipes
	end

	def get_recipe_list_from_group_by_meal!(recipes, meal)
		@filtered_recipes_by_meal = []
		recipes.each do |recipe|
			recipe.characteristics.each do |characteristic|
				if characteristic.name == meal
					@filtered_recipes_by_meal << recipe
				end
			end
		end
		return @filtered_recipes_by_meal
	end

	def get_recipe!
	end
end
