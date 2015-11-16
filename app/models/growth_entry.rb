class GrowthEntry < ActiveRecord::Base
  belongs_to :growth_chart
  default_scope { order('measured_at DESC') }
end
