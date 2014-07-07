class QualityReview < ActiveRecord::Base
  belongs_to :dietitian
  ## polymorphic, belongs to with either article ingredient or recipe

end
