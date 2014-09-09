class Ingredient < ActiveRecord::Base
  attr_accessor :ingredient_characteristics

  has_many :ingredients_recipes
  has_many :recipes, through: :ingredients_recipes
  has_and_belongs_to_many :allergens, :uniq => true
  has_many :quality_reviews, as: :quality_reviewable 
  # method to check if an ingredient has had allergens added
  def need_allergens?
    # if an ingredient has allergens already
    if self.allergens.count >= 1
      return false
    # if no allergens have been attached yet
    else
      return true
    end
  end
  
  # returns ingredient allergens that are not in the top 10 or self
  def other_allergens
    other_allergens = self.allergens
    main_allergens = Allergen.first(10)
    other_allergens = other_allergens - main_allergens
    other_allergens = other_allergens - Allergen.where(name: self.name)
    return other_allergens
  end

  def split_ingredient_by_word
    array_of_words = self.name.gsub(/\s+/m, ' ').gsub(/^\s+|\s+$/m, '').split(" ")
    return array_of_words
  end

  # returns suggested allergens for an ingredient based on if a word in the ingredient matches a word in an allergen or matches a word in another ingredient
  # includes too many ingredients that are their own allergen, needs to filter out "soy sauce" as a suggested allergen without filtering out "egg"
  # should maybe have a limit to how many display
  def suggested_allergens
    suggested_allergens = []
    # splits ingredient by word 
    # example "string bean" to ["string", "bean"]
    words_in_name = self.split_ingredient_by_word
    # iterate through each word in the ingredient
    words_in_name.each do |word_in_name|
      # iterate trough each ingredient
      Allergen.all.each do |allergen|       
        allergen.split_allergen_by_word.each do |allergen_word|
          # if word in allergen matches word in ingredient then add to suggested
          if allergen_word == word_in_name
            suggested_allergens << allergen
          end
        end
      end
      Ingredient.all.each do| ingredient|
        ingredient.split_ingredient_by_word.each do |ingredient_word|
          # if word in other ingredient names match word in ingredient then add to suggested
          if ingredient_word == word_in_name
            ingredient.allergens.each do |allergen|
              suggested_allergens << allergen
            end
          end
        end
      end
    end
    return suggested_allergens
  end

end
