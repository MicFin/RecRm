class AllergensIngredient < ActiveRecord::Base
  belongs_to :allergen
  belongs_to :ingredient
  accepts_nested_attributes_for :allergen


end
