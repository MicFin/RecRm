require 'test_helper'

class AttributesControllerTest < ActionController::TestCase
  setup do
    @attribute = attributes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:attributes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create attribute" do
    assert_difference('Attribute.count') do
      post :create, attribute: { name: @attribute.name, category: @attribute.category  }
    end

    assert_redirected_to attribute_path(assigns(:attribute))
  end

  test "should show attribute" do
    get :show, id: @attribute
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @attribute
    assert_response :success
  end

  test "should update attribute" do
    patch :update, id: @attribute, attribute: { name: @attribute.name, category: @attribute.category )
  end

  test "should destroy attribute" do
    assert_difference('Attribute.count', -1) do
      delete :destroy, id: @attribute
    end

    assert_redirected_to attributes_path
  end
end
