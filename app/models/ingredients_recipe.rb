require 'unitwise'
require 'unitwise/ext'

class IngredientsRecipe < ActiveRecord::Base
	belongs_to :ingredient
	belongs_to :recipe


#### need to decide what unit types we will allow a user to select from and then we can save the data in the most basic format IE the user may want to enter it in tons, or pounds or ounces but we can save all weight entries as ounces  ####

  # def amount
  #   read_attribute(:amount).convert_to(self.amount_unit)
  # end

  # def amount=(value)
  #   write_attribute :amount, value.to_tablespoon
  #   if value.respond_to?(:unit)
  #     self.amount_unit = value.unit.to_s
  #   end
  # end

end
