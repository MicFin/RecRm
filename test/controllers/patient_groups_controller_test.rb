# == Schema Information
#
# Table name: patient_groups
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  category     :string(255)
#  description  :text
#  order        :integer
#  input_option :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  unverified   :boolean          default(FALSE)
#  has_triggers :boolean          default(FALSE), not null
#

require 'test_helper'

class PatientGroupsControllerTest < ActionController::TestCase
  setup do
    @patient_group = patient_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:patient_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create patient_group" do
    assert_difference('PatientGroup.count') do
      post :create, patient_group: { name: @patient_group.name, category: @patient_group.category  }
    end

    assert_redirected_to patient_group_path(assigns(:patient_group))
  end

  test "should show patient_group" do
    get :show, id: @patient_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @patient_group
    assert_response :success
  end

  test "should update patient_group" do
    patch :update, id: @patient_group, patient_group: { step_number: @patient_group.step_number, directions: @patient_group.directions, recipe_id: @patient_group.recipe_id }
  end

  test "should destroy patient_group" do
    assert_difference('PatientGroup.count', -1) do
      delete :destroy, id: @patient_group
    end

    assert_redirected_to patient_groups_path
  end
end
