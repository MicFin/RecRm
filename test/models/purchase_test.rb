# == Schema Information
#
# Table name: purchases
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  purchasable_id    :integer
#  purchasable_type  :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  stripe_card_token :string(255)
#  invoice_price     :integer
#  invoice_cost      :integer
#  status            :string(255)
#  completed_at      :datetime
#

require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
