class GrowthChart < ActiveRecord::Base
  belongs_to :user
  has_many :growth_entries
end
