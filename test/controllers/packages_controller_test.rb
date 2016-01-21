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

require 'test_helper'

class PackagesControllerTest < ActionController::TestCase
  setup do
    @package = packages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:packages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create package" do
    assert_difference('Package.count') do
      post :create, package: { description: @package.description, expiration_in_months: @package.expiration_in_months, full_price: @package.full_price, name: @package.name, num_full_appointments: @package.num_full_appointments, num_half_appointments: @package.num_half_appointments, type: @package.type }
    end

    assert_redirected_to package_path(assigns(:package))
  end

  test "should show package" do
    get :show, id: @package
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @package
    assert_response :success
  end

  test "should update package" do
    patch :update, id: @package, package: { description: @package.description, expiration_in_months: @package.expiration_in_months, full_price: @package.full_price, name: @package.name, num_full_appointments: @package.num_full_appointments, num_half_appointments: @package.num_half_appointments, type: @package.type }
    assert_redirected_to package_path(assigns(:package))
  end

  test "should destroy package" do
    assert_difference('Package.count', -1) do
      delete :destroy, id: @package
    end

    assert_redirected_to packages_path
  end
end
