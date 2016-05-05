# == Schema Information
#
# Table name: families
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  location          :string(255)
#  head_of_family_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class FamiliesController < ApplicationController
  include PatientGroupsHelper
  include FamiliesHelper
  before_action :set_family, only: [:show, :edit, :edit_family_member, :new_family_member, :show_family_member, :update, :destroy, :remove_member]

  # GET /families
  # GET /families.json
  def index
    @families = Family.all
  end

  # GET /families/1
  # GET /families/1.json
  def show
    @user = Users::UserPresenter.new(@family.head_of_family)

    @family = Families::FamilyPresenter.new(@family)

    # New user for form
    @new_user = User.new(last_name: @user.last_name)
    @growth_chart = GrowthChart.new
    @food_diary = FoodDiary.new
    respond_to do |format|

       format.js
       format.html
    end
  end

  # GET /families/new
  def new

    @user = current_user
    @family = current_user.head_of_families.create
    # @family = Family.new
    @new_user = @family.users.build(last_name: @user.last_name)

  end

  # POST /families
  # POST /families.json
  def create
    @family = Family.new(family_params)
    @user = current_user
    # if no user is selected for appointment then default to main user
    if params["patient_focus"] == nil
      params["patient_focus"] = @user.id
    end
    respond_to do |format|
      if @family.save
        format.html { redirect_to @family, notice: 'Family was successfully created.' }
        format.json { render :show, status: :created, location: @family }
      else
        format.html { render :new }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /families/1/edit
  def edit

  end

  # PATCH/PUT /families/1
  # PATCH/PUT /families/1.json
  def update
    respond_to do |format|
      if @family.update(family_params)
        format.html { redirect_to @family, notice: 'Family was successfully updated.' }
        format.json { render :show, status: :ok, location: @family }
      else
        format.html { render :edit }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /families/1
  # DELETE /families/1.json
  def destroy
    @family.destroy
    respond_to do |format|
      format.html { redirect_to families_url, notice: 'Family was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /families/1/new_family_member/
  def new_family_member
    @user = current_user
    @family_member = User.new(last_name: @user.last_name)
    @user = @family_member
    # PatientGroupsHelper
    get_patient_groups!
    @diseases
    @intolerances
    @allergies
    @symptoms
    @diets

    respond_to do |format|

      format.html
      format.js
    end
  end

  # GET /families/1/edit_family_member/2
  def edit_family_member
    @user = current_user
    @family_member = Users::UserPresenter.new(User.find(params[:member_id]))
    # health group forms use @user and hsould use @family_member
    @user = @family_member
    @family_member.health_groups = @family_member.patient_groups 
    @growth_chart = GrowthChart.new
    @food_diary = FoodDiary.new

    # PatientGroupsHelper
    get_patient_groups!
    @diseases
    @intolerances
    @allergies
    @symptoms
    @diets

    respond_to do |format|
       format.js
       format.html
    end
  end

  # DELETE /families/:id/remove_member/:member_id
  def remove_member
    @removed_member_id = params[:member_id]
    @appointment = current_user.appointment_hosts.last
    @family_member = User.find(@removed_member_id)

    respond_to do |format|
      if @family_member.destroy
        format.html { redirect_to @family, notice: 'Family member was successfully removed.' }
        format.json { head :no_content }
        format.js
      else

        flash.now[:error] = "Can not delete family member's that have appointments assigned to them."
        format.html { redirect_to families_edit_family_member_path(@family, @family_member) }
        format.json { render json: @family.errors, status: :unprocessable_entity }     
        format.js    
      end
    end
  end

  # GET /families/1/show_family_member/2
  def show_family_member
    @user = current_user
    @family_member = Users::UserPresenter.new(User.find(params[:member_id]))
    @family_member.health_groups = @family_member.patient_groups 

    # Create growth chart or food diary if not already created
    # should only need this for old users, could run script to create a growth and diary for all old users
    @family_member.growth_chart || GrowthChart.create(user_id: @family_member.id)
    @family_member.food_diary || FoodDiary.create(user_id: @family_member.id)

    @food_diary_entry = FoodDiaryEntry.new
    @growth_entry = GrowthEntry.new

    respond_to do |format|
      format.html 
      format.js
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_family
    @family = Family.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def family_params
    
    params.require(:family).permit(:name, :location, :head_of_family_id, :created_at, :updated_at)
  end

  # Height and weight must be changed from ft+in and lb+oz to just inches and ounces before being saved
  def clean_height_and_weight_input

    # Check if user input was submitted
    if params["user"]

      # Check if user height was submitted
      if params["user"]["height"]

        # Check if user height feet was submitted
        if (params["user"]["height"]["feet"].to_i >= 1)

          # Convert feet to inches
          params["user"]["height"]["feet"] = params["user"]["height"]["feet"].to_i * 12

          # Add to inches to get a total in inches
          params["user"]["height_inches"] = params["user"]["height"]["feet"].to_i + params["user"]["height"]["inches"].to_i

        # If no feet submitted then update param
        else 
            params["user"]["height_inches"] = params["user"]["height"]["inches"].to_i
        end

        # Delete height param since it will be saved as height_inches
        params["user"].delete "height"
      end

      # Check if user weight was submitted
      if params["user"]["weight"]

        # Check if user weight pounds was submitted
        if (params["user"]["weight"]["pounds"].to_i >= 1)

          # Convert pounds to ounces
          params["user"]["weight"]["pounds"] = params["user"]["weight"]["pounds"].to_i * 16
          
          # Add to ounces to get a total in ounces
          params["user"]["weight_ounces"] = params["user"]["weight"]["pounds"].to_i + params["user"]["weight"]["ounces"].to_i

        # If no feet submitted then update param
        else 
            params["user"]["weight_ounces"] = params["user"]["weight"]["ounces"].to_i
        end

        # Delete weight param since it will be saved as weight_ounces
        params["user"].delete "weight"
      end
    end
  end

  # If a user submits new health groups then check if they are in our database or create them and prepare them to be saved
  def find_or_create_new_health_groups
    
    # Check if user input was submitted
    if params["user"]

      # Check if health new health groups were submitted
      if params["new_health_groups"]

        #  Find or create new health groups and add them to the params to be saved
        params["new_health_groups"].each do |group_type, health_groups|
          health_groups.each do |health_group|
            group = PatientGroup.find_or_create_by(name: health_group, unverified: true, category: group_type, order: 10000) 
            group.save
            params["user"]["patient_group_ids"].push(group.id)
          end 
        end

        # Delete the new health groups param
        params.delete "new_health_groups"
      end 
    end
  end


end
