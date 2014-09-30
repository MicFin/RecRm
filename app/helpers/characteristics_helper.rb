module CharacteristicsHelper

    def get_recipe_characteristics!
      @cook_times = Characteristic.where(category: "Cook Time").order(:order)
      @cook_count = @cook_times.count
      @prep_times = Characteristic.where(category: "Prep Time").order(:order)
      @prep_count = @prep_times.count
      @difficulties = Characteristic.where(category: "Difficulty").order(:order)
      @difficulty_count = @difficulties.count
      @serving_sizes = Characteristic.where(category: "Serving Size").order(:order)
      
      @courses = Characteristic.where(category: "Course").order(:order)
      @meals = Characteristic.where(category: "Meal").order(:order)
      @cultures = Characteristic.where(category: "Culture").order(:name)
    end

	def do_somthing!
	end

end
