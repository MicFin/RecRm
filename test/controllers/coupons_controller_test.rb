# == Schema Information
#
# Table name: coupons
#
#  id                :integer          not null, primary key
#  code              :string(255)
#  description       :string(255)
#  valid_from        :datetime
#  valid_until       :datetime
#  redemption_limit  :integer          default(1)
#  redemptions_count :integer          default(0)
#  amount            :integer
#  amount_type       :string(255)
#  status            :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

require 'test_helper'

class CouponsControllerTest < ActionController::TestCase
  setup do
    @coupon = coupons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coupons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coupon" do
    assert_difference('Coupon.count') do
      post :create, coupon: { amount: @coupon.amount, code: @coupon.code, description: @coupon.description, redemption_limit: @coupon.redemption_limit, redemptions_count: @coupon.redemptions_count, status: @coupon.status, type: @coupon.type, valid_from: @coupon.valid_from, valid_until: @coupon.valid_until }
    end

    assert_redirected_to coupon_path(assigns(:coupon))
  end

  test "should show coupon" do
    get :show, id: @coupon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coupon
    assert_response :success
  end

  test "should update coupon" do
    patch :update, id: @coupon, coupon: { amount: @coupon.amount, code: @coupon.code, description: @coupon.description, redemption_limit: @coupon.redemption_limit, redemptions_count: @coupon.redemptions_count, status: @coupon.status, type: @coupon.type, valid_from: @coupon.valid_from, valid_until: @coupon.valid_until }
    assert_redirected_to coupon_path(assigns(:coupon))
  end

  test "should destroy coupon" do
    assert_difference('Coupon.count', -1) do
      delete :destroy, id: @coupon
    end

    assert_redirected_to coupons_path
  end
end
