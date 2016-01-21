# == Schema Information
#
# Table name: subscriptions
#
#  id                   :integer          not null, primary key
#  member_plan_id       :integer
#  user_id              :integer
#  start_date           :datetime
#  end_date             :datetime
#  type                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  trial_end            :datetime
#  trial_start          :datetime
#  ended_at             :datetime
#  current_period_start :datetime
#  current_period_end   :datetime
#  cancelled_at         :datetime
#  status               :string(255)
#  quantity             :integer          default(1)
#  stripe_id            :integer
#

require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  setup do
    @subscription = subscriptions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subscription" do
    assert_difference('Subscription.count') do
      post :create, subscription: {  }
    end

    assert_redirected_to subscription_path(assigns(:subscription))
  end

  test "should show subscription" do
    get :show, id: @subscription
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subscription
    assert_response :success
  end

  test "should update subscription" do
    patch :update, id: @subscription, subscription: {  }
    assert_redirected_to subscription_path(assigns(:subscription))
  end

  test "should destroy subscription" do
    assert_difference('Subscription.count', -1) do
      delete :destroy, id: @subscription
    end

    assert_redirected_to subscriptions_path
  end
end
