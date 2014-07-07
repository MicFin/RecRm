class MarketingItem < ActiveRecord::Base
  ## polymorphic, belongs to with either patient group or characteristics
  belongs_to :dietitian
end
 