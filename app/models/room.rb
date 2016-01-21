# == Schema Information
#
# Table name: rooms
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  sessionId    :string(255)
#  public       :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  dietitian_id :integer
#

class Room < ActiveRecord::Base
  has_many :appointments
  belongs_to :dietitian
  resourcify
end
