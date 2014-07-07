class Article < ActiveRecord::Base
  belongs_to :dietitian
  has_and_belongs_to_many :characteristics
  has_and_belongs_to_many :patient_groups
  has_many :marketing_items, as: :marketing_itemable 
end
