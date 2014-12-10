class QualityReview < ActiveRecord::Base
  attr_accessor :recipe_title
  attr_accessor :number_of_ingredients
  attr_accessor :health_groups_names

  belongs_to :dietitian
  ## polymorphic, belongs to with either article ingredient or recipe
  belongs_to :quality_reviewable, polymorphic: true # belongs to either article, recipe or ingredient
  has_many :review_conflicts

  resourcify
  
  def health_group_array
    health_groups = []
    self.quality_reviewable.patient_groups.each do |health_group|
      health_groups << health_group.name 
    end
    return health_groups
  end

  def ingredient_count
    self.quality_reviewable.ingredients_recipes.count
  end

  def recipe_name
    self.quality_reviewable.name
  end

  def conflicts_cleared?
    self.review_conflicts.each do |conflict|
      if conflict.resolved == false
        return false
      end
    end
    return true
  end
  
end
