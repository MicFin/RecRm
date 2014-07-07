class MarketingItem < ActiveRecord::Base
  ## polymorphic, belongs to with either patient group or characteristics
  belongs_to :dietitian
  belongs_to :marketing_tiemable, polymorphic: true
end
 