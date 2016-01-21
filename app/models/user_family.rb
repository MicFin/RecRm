# == Schema Information
#
# Table name: user_families
#
#  id        :integer          not null, primary key
#  user_id   :integer
#  family_id :integer
#

class UserFamily < ActiveRecord::Base
  belongs_to :user
  belongs_to :family
end
