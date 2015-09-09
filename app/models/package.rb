class Package < ActiveRecord::Base
  has_one :purchase, as: :purchasable

  def show_full_price
    return "$"+'%.2f' % (full_price.to_i/100.0)
  end

end
