class QualityReview < ActiveRecord::Base
  belongs_to :dietitian
  ## polymorphic, belongs to with either article ingredient or recipe
  belongs_to :quality_reviewable, polymorphic: true # belongs to either article, recipe or ingredient
  has_many :review_conflicts

  resourcify
  
end
