require 'test_helper'

class ContentQuotaControllerTest < ActionController::TestCase
  setup do
    @content_quotum = content_quota(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:content_quota)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create content_quotum" do
    assert_difference('ContentQuotum.count') do
      post :create, content_quotum: {  }
    end

    assert_redirected_to content_quotum_path(assigns(:content_quotum))
  end

  test "should show content_quotum" do
    get :show, id: @content_quotum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @content_quotum
    assert_response :success
  end

  test "should update content_quotum" do
    patch :update, id: @content_quotum, content_quotum: {  }
    assert_redirected_to content_quotum_path(assigns(:content_quotum))
  end

  test "should destroy content_quotum" do
    assert_difference('ContentQuotum.count', -1) do
      delete :destroy, id: @content_quotum
    end

    assert_redirected_to content_quota_path
  end
end
