class Package < ActiveRecord::Base
  has_many :user_packages
end
