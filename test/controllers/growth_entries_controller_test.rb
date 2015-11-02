require 'test_helper'

class GrowthEntriesControllerTest < ActionController::TestCase
  setup do
    @growth_entry = growth_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:growth_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create growth_entry" do
    assert_difference('GrowthEntry.count') do
      post :create, growth_entry: { age: @growth_entry.age, entry_measured_at: @growth_entry.entry_measured_at, growth_chart_id: @growth_entry.growth_chart_id, height_in_inches: @growth_entry.height_in_inches, weight_in_ounces: @growth_entry.weight_in_ounces }
    end

    assert_redirected_to growth_entry_path(assigns(:growth_entry))
  end

  test "should show growth_entry" do
    get :show, id: @growth_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @growth_entry
    assert_response :success
  end

  test "should update growth_entry" do
    patch :update, id: @growth_entry, growth_entry: { age: @growth_entry.age, entry_measured_at: @growth_entry.entry_measured_at, growth_chart_id: @growth_entry.growth_chart_id, height_in_inches: @growth_entry.height_in_inches, weight_in_ounces: @growth_entry.weight_in_ounces }
    assert_redirected_to growth_entry_path(assigns(:growth_entry))
  end

  test "should destroy growth_entry" do
    assert_difference('GrowthEntry.count', -1) do
      delete :destroy, id: @growth_entry
    end

    assert_redirected_to growth_entries_path
  end
end
