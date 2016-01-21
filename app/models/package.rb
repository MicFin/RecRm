# == Schema Information
#
# Table name: packages
#
#  id                    :integer          not null, primary key
#  category              :string(255)
#  name                  :string(255)
#  full_price            :integer
#  description           :text
#  num_half_appointments :integer
#  num_full_appointments :integer
#  expiration_in_months  :integer
#  created_at            :datetime
#  updated_at            :datetime
#

class Package < ActiveRecord::Base
  has_many :purchases, as: :purchasable
  has_many :user_packages
  has_many :users, through: :user_packages


  def show_full_price
    return "$"+'%.2f' % (full_price.to_i/100.0)
  end

end
