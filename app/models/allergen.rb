class Allergen < ActiveRecord::Base
	has_and_belongs_to_many :patient_groups
	has_and_belongs_to_many :ingredients

  def split_allergen_by_word
    array_of_words = self.name.gsub(/\s+/m, ' ').gsub(/^\s+|\s+$/m, '').split(" ")
    return array_of_words
  end


end
