require 'test_helper'

class MemberPlansControllerTest < ActionController::TestCase
  setup do
    @member_plan = member_plans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:member_plans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member_plan" do
    assert_difference('MemberPlan.count') do
      post :create, member_plan: { name: @member_plan.name }
    end

    assert_redirected_to member_plan_path(assigns(:member_plan))
  end

  test "should show member_plan" do
    get :show, id: @member_plan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @member_plan
    assert_response :success
  end

  test "should update member_plan" do
    patch :update, id: @member_plan, member_plan: { name: @member_plan.name }
    assert_redirected_to member_plan_path(assigns(:member_plan))
  end

  test "should destroy member_plan" do
    assert_difference('MemberPlan.count', -1) do
      delete :destroy, id: @member_plan
    end

    assert_redirected_to member_plans_path
  end
end
