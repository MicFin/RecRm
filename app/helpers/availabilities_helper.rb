# == Schema Information
#
# Table name: availabilities
#
#  id                  :integer          not null, primary key
#  start_time          :datetime
#  end_time            :datetime
#  buffered_start_time :datetime
#  buffered_end_time   :datetime
#  dietitian_id        :integer
#  created_at          :datetime
#  updated_at          :datetime
#  status              :string(255)
#

module AvailabilitiesHelper
end
