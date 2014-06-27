require 'test_helper'

class RecipeStepsControllerTest < ActionController::TestCase
  setup do
    @recipe_step = recipe_steps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipe_steps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipe_step" do
    assert_difference('RecipeStep.count') do
      post :create, recipe_step: { name: @recipe_step.name, category: @recipe_step.category  }
    end

    assert_redirected_to recipe_step_path(assigns(:recipe_step))
  end

  test "should show recipe_step" do
    get :show, id: @recipe_step
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recipe_step
    assert_response :success
  end

  test "should update recipe_step" do
    patch :update, id: @recipe_step, recipe_step: { name: @recipe_step.name, category: @recipe_step.category )
  end

  test "should destroy recipe_step" do
    assert_difference('RecipeStep.count', -1) do
      delete :destroy, id: @recipe_step
    end

    assert_redirected_to recipe_steps_path
  end
end
