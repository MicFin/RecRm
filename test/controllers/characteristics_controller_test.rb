require 'test_helper'

class CharacteristicsControllerTest < ActionController::TestCase
  setup do
    @characteristic = characteristics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:characteristics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create characteristic" do
    assert_difference('Characteristic.count') do
      post :create, characteristic: { name: @characteristic.name, category: @characteristic.category  }
    end

    assert_redirected_to characteristic_path(assigns(:characteristic))
  end

  test "should show characteristic" do
    get :show, id: @characteristic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @characteristic
    assert_response :success
  end

  test "should update characteristic" do
    patch :update, id: @characteristic, characteristic: { name: @characteristic.name, category: @characteristic.category )
  end

  test "should destroy characteristic" do
    assert_difference('Characteristic.count', -1) do
      delete :destroy, id: @characteristic
    end

    assert_redirected_to characteristics_path
  end
end
