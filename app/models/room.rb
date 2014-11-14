class Room < ActiveRecord::Base
  has_many :appointments
  resourcify
end
