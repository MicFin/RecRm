class QualityReview < ActiveRecord::Base
  belongs_to :dietitian
  ## polymorphic, belongs to with either article ingredient or recipe
belongs_to :quality_reviewable, polymorphic: true
end
