class Characteristic < ActiveRecord::Base
  has_and_belongs_to_many :recipes
  has_many :marketing_items ## polymorphic relationship
end
