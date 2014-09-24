module CharacteristicsHelper

    def get_recipe_characteristics!
      @cook_times = Characteristic.where(category: "Cook Time")
      @cook_count = @cook_times.count
      @prep_times = Characteristic.where(category: "Prep Time")
      @prep_count = @prep_times.count
      @difficulties = Characteristic.where(category: "Difficulty")
      @difficulty_count = @difficulties.count
      @serving_sizes = Characteristic.where(category: "Serving Size")
      
      @courses = Characteristic.where(category: "Course").order(:order)
      @meals = Characteristic.where(category: "Meal").order(:order)
      @cultures = Characteristic.where(category: "Culture").order(:name)
    end

	def do_somthing!
	end

end
