class RecipeStep < ActiveRecord::Base
	attr_accessor :ingredient_list

	belongs_to :recipe
	has_and_belongs_to_many :ingredients_recipes
  resourcify

  def ingredients_full_names
    full_names = []
    self.ingredients_recipes.each do |ingredient|
      full_names << ingredient.full_name
    end
    return full_names
  end

  # return a string of the entire 
  def full_step
    all_ingredients_string = ""
    self.ingredients_recipes.each do |ingredient|
      all_ingredients_string += "#{ingredient.full_name} + "
    end  
    all_ingredients_string = all_ingredients_string[0..-4]
    return "Position: #{self.position} Directions: #{self.directions} Ingredients: #{all_ingredients_string}" 
  end
end

