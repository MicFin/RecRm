module CharacteristicsHelper

    def get_recipe_characteristics!
      @cook_times = Characteristic.where(category: "Cook Time")
      @cook_count = @cook_times.count
      @prep_times = Characteristic.where(category: "Prep Time")
      @prep_count = @prep_times.count
      # @prep_times = {}
      # @prep_times.count = @prep_times_all.count
      # @prep_times.options ={}
      # @prep_times_all.each do | index, prep_time |
      #   binding.pry
      # end

      
      @difficulties = Characteristic.where(category: "Difficulty")
      @difficulty_count = @difficulties.count
      # @courses = @recipe.characteristics.where(category: "Course")
      # @age_groups = @recipe.characteristics.where(category: "Age Group")
      # @scenarios = @recipe.characteristics.where(category: "Scenario")
      # @holidays = @recipe.characteristics.where(category: "Holiday")
      # @cultures = @recipe.characteristics.where(category: "Culture")
    end

	def do_somthing!
	end

end
