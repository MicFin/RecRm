class Allergen < ActiveRecord::Base
	has_and_belongs_to_many :patient_groups
	has_and_belongs_to_many :ingredients
end
