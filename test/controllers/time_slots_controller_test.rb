# == Schema Information
#
# Table name: time_slots
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  start_time      :datetime
#  end_time        :datetime
#  created_at      :datetime
#  updated_at      :datetime
#  minutes         :integer
#  status          :string(255)
#  availability_id :integer
#  vacancy         :boolean          default(TRUE)
#

require 'test_helper'

class TimeSlotsControllerTest < ActionController::TestCase
  setup do
    @time_slot = time_slots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:time_slots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_slot" do
    assert_difference('TimeSlot.count') do
      post :create, time_slot: { end_time: @time_slot.end_time, start_time: @time_slot.start_time, title: @time_slot.title }
    end

    assert_redirected_to time_slot_path(assigns(:time_slot))
  end

  test "should show time_slot" do
    get :show, id: @time_slot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @time_slot
    assert_response :success
  end

  test "should update time_slot" do
    patch :update, id: @time_slot, time_slot: { end_time: @time_slot.end_time, start_time: @time_slot.start_time, title: @time_slot.title }
    assert_redirected_to time_slot_path(assigns(:time_slot))
  end

  test "should destroy time_slot" do
    assert_difference('TimeSlot.count', -1) do
      delete :destroy, id: @time_slot
    end

    assert_redirected_to time_slots_path
  end
end
