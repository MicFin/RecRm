# == Schema Information
#
# Table name: food_diary_entries
#
#  id            :integer          not null, primary key
#  food_diary_id :integer
#  consumed_at   :datetime
#  food_item     :string(255)
#  location      :string(255)
#  note          :text
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

class FoodDiaryEntriesControllerTest < ActionController::TestCase
  setup do
    @food_diary_entry = food_diary_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:food_diary_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create food_diary_entry" do
    assert_difference('FoodDiaryEntry.count') do
      post :create, food_diary_entry: { consumed_at: @food_diary_entry.consumed_at, food_diary_id: @food_diary_entry.food_diary_id, food_item: @food_diary_entry.food_item, location: @food_diary_entry.location, note: @food_diary_entry.note }
    end

    assert_redirected_to food_diary_entry_path(assigns(:food_diary_entry))
  end

  test "should show food_diary_entry" do
    get :show, id: @food_diary_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @food_diary_entry
    assert_response :success
  end

  test "should update food_diary_entry" do
    patch :update, id: @food_diary_entry, food_diary_entry: { consumed_at: @food_diary_entry.consumed_at, food_diary_id: @food_diary_entry.food_diary_id, food_item: @food_diary_entry.food_item, location: @food_diary_entry.location, note: @food_diary_entry.note }
    assert_redirected_to food_diary_entry_path(assigns(:food_diary_entry))
  end

  test "should destroy food_diary_entry" do
    assert_difference('FoodDiaryEntry.count', -1) do
      delete :destroy, id: @food_diary_entry
    end

    assert_redirected_to food_diary_entries_path
  end
end
