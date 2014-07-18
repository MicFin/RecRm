module CharacteristicsHelper

    def get_recipe_characteristics!
      @cook_time = @recipe.characteristics.where(category: "Cook Time").first
      @prep_time = @recipe.characteristics.where(category: "Prep Time").first
      @difficulty = @recipe.characteristics.where(category: "Difficulty").first
      @courses = @recipe.characteristics.where(category: "Course")
      @age_groups = @recipe.characteristics.where(category: "Age Group")
      @scenarios = @recipe.characteristics.where(category: "Scenario")
      @holidays = @recipe.characteristics.where(category: "Holiday")
      @cultures = @recipe.characteristics.where(category: "Culture")
    end

	def do_somthing!
	end

end
