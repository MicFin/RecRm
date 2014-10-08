class MarketingItem < ActiveRecord::Base
  ## polymorphic, belongs to with either patient group or characteristics
  belongs_to :dietitian
  belongs_to :marketing_itemable, polymorphic: true # belongs to either article or recipe
  has_and_belongs_to_many :characteristics
  belongs_to :patient_group
  resourcify
end
 