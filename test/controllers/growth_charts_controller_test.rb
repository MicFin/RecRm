require 'test_helper'

class GrowthChartsControllerTest < ActionController::TestCase
  setup do
    @growth_chart = growth_charts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:growth_charts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create growth_chart" do
    assert_difference('GrowthChart.count') do
      post :create, growth_chart: { user_id: @growth_chart.user_id }
    end

    assert_redirected_to growth_chart_path(assigns(:growth_chart))
  end

  test "should show growth_chart" do
    get :show, id: @growth_chart
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @growth_chart
    assert_response :success
  end

  test "should update growth_chart" do
    patch :update, id: @growth_chart, growth_chart: { user_id: @growth_chart.user_id }
    assert_redirected_to growth_chart_path(assigns(:growth_chart))
  end

  test "should destroy growth_chart" do
    assert_difference('GrowthChart.count', -1) do
      delete :destroy, id: @growth_chart
    end

    assert_redirected_to growth_charts_path
  end
end
