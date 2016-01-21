# == Schema Information
#
# Table name: food_diaries
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class FoodDiariesControllerTest < ActionController::TestCase
  setup do
    @food_diary = food_diaries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:food_diaries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create food_diary" do
    assert_difference('FoodDiary.count') do
      post :create, food_diary: { user_id: @food_diary.user_id }
    end

    assert_redirected_to food_diary_path(assigns(:food_diary))
  end

  test "should show food_diary" do
    get :show, id: @food_diary
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @food_diary
    assert_response :success
  end

  test "should update food_diary" do
    patch :update, id: @food_diary, food_diary: { user_id: @food_diary.user_id }
    assert_redirected_to food_diary_path(assigns(:food_diary))
  end

  test "should destroy food_diary" do
    assert_difference('FoodDiary.count', -1) do
      delete :destroy, id: @food_diary
    end

    assert_redirected_to food_diaries_path
  end
end
