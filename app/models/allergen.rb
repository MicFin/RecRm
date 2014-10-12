class Allergen < ActiveRecord::Base
	has_and_belongs_to_many :patient_groups
	has_and_belongs_to_many :ingredients

  def split_allergen_by_word
    array_of_words = self.name.gsub(/\s+/m, ' ').gsub(/^\s+|\s+$/m, '').split(" ")
    return array_of_words
  end

  def self.top_allergens
    self.where(top_allergen: true)
  end

  def self.common_allergens
    self.where(common_allergen: true).order(:name)
  end

  def self.find_or_create_allergen(name)
    allergen = Allergen.find_by(name: name.downcase)
    if !allergen
      # if not create the allergen
      allergen = Allergen.new(name: name.downcase)
      allergen.save!
    end
    return allergen
  end
end
