class Package < ActiveRecord::Base
  has_one :purchase, as: :purchasable
  has_many :user_packages
  has_many :users, through: :user_packages


  def show_full_price
    return "$"+'%.2f' % (full_price.to_i/100.0)
  end

end
