require 'test_helper'

class AppointmentsControllerTest < ActionController::TestCase
  setup do
    @appointment = appointments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:appointments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create appointment" do
    assert_difference('Appointment.count') do
      post :create, appointment: { appointment_host_id: @appointment.appointment_host_id, client_note: @appointment.client_note, created_at: @appointment.created_at, date: @appointment.date, dietitian_id: @appointment.dietitian_id, note: @appointment.note, patient_focus_id: @appointment.patient_focus_id, room_id: @appointment.room_id, updated_at: @appointment.updated_at }
    end

    assert_redirected_to appointment_path(assigns(:appointment))
  end

  test "should show appointment" do
    get :show, id: @appointment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @appointment
    assert_response :success
  end

  test "should update appointment" do
    patch :update, id: @appointment, appointment: { appointment_host_id: @appointment.appointment_host_id, client_note: @appointment.client_note, created_at: @appointment.created_at, date: @appointment.date, dietitian_id: @appointment.dietitian_id, note: @appointment.note, patient_focus_id: @appointment.patient_focus_id, room_id: @appointment.room_id, updated_at: @appointment.updated_at }
    assert_redirected_to appointment_path(assigns(:appointment))
  end

  test "should destroy appointment" do
    assert_difference('Appointment.count', -1) do
      delete :destroy, id: @appointment
    end

    assert_redirected_to appointments_path
  end
end
