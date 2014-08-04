require 'unitwise'
require 'unitwise/ext'

class IngredientsRecipe < ActiveRecord::Base
	belongs_to :ingredient
	belongs_to :recipe
  accepts_nested_attributes_for :ingredient

  # could not get client side validation to work on this new ingredients recipe form so removed server validation until both are working)
  # validates :amount, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }

#### need to decide what unit types we will allow a user to select from and then we can save the data in the most basic format IE the user may want to enter it in tons, or pounds or ounces but we can save all weight entries as ounces  ####

  ## convert the avalue to a specific unit type when retrieved

  # def amount
  #   read_attribute(:amount).convert_to(self.amount_unit)
  # end

  ## store the value as a specific unit type in the database. Will need to add logic based on what type of unit is inputted

  # def amount=(value)
  #   write_attribute :amount, value.to_tablespoon
  #   if value.respond_to?(:unit)
  #     self.amount_unit = value.unit.to_s
  #   end
  # end

  # find or create ingredient by name
  def find_or_create_ingredient(name)
    ingredient = Ingredient.find_by(name: name.downcase)
    if !ingredient
      # if not create the ingredient
      ingredient = Ingredient.new(name: name.downcase)
      ingredient.save!
    end
    self.ingredient_id = ingredient.id
    self.save!
  end

 #  over ride rails validate_associated_record_for_ingredient to blank since find_or_create_ingredient(name) is similar
  def autosave_associated_records_for_ingredient
  end

  ## return the full name of the ingredient including both prep terms
  # def full_name
  #   prep1 = self.prep
  #   prep2 = self.prep2
  #   if prep1 != nil 
  #     full_name = prep1 + " " + self.ingredient.name
  #   else
  #     full_name = self.ingredient.name
  #   end
  #   if prep2 != nil 
  #     full_name += " " + prep2 
  #   end
  #   return full_name
  # end

end
