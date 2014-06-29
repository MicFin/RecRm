class Recipe < ActiveRecord::Base
	has_many :ingredients_recipes
	has_many :ingredients, through: :ingredients_recipes
	has_many :recipe_steps
  has_and_belongs_to_many :characteristics
  # removed until can utlilize AJAX to render nested forms for recipe form or to submit for ingredients_recipes forms
  # accepts_nested_attributes_for :ingredients_recipes

  # return a recipe's ingredients that have already been tagged with allergens
  def ingredients_tagged
    tagged_ingredients = []
    self.ingredients.each do |ingredient|
      if ingredient.need_allergens? == false
        tagged_ingredients << ingredient
      end
    end
    return tagged_ingredients
  end

  # return a recipe's ingredients that have not yet been tagged with allergens
  def ingredients_not_tagged
    not_tagged_ingredients = []
    self.ingredients.each do |ingredient|
      if ingredient.need_allergens? == true 
        not_tagged_ingredients << ingredient
      end
    end
    return not_tagged_ingredients
  end

end
