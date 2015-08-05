class FamiliesController < ApplicationController
  include PatientGroupsHelper
  include FamiliesHelper
  before_action :set_family, only: [:show, :edit, :edit_family_member, :update, :destroy]

  # GET /families
  # GET /families.json
  def index
    @families = Family.all
  end

  # GET /families/1
  # GET /families/1.json
  def show
    @user = current_user

    # Gather user's family data
    # from FamiliessHelper
    get_family_members!
  end

  # GET /families/new
  def new
    
    @user = current_user
    @family = current_user.head_of_families.create
    # @family = Family.new
    @new_user = @family.users.build(last_name: @user.last_name)
   
    # get_patient_groups!
    # @diseases = @diseases 
    # @intolerances = @intolerances 
    # @allergies = @allergies
    # @diets =  @diets 

    # respond_to do |format|
    #   format.js
    #   format.html
    # end
  end

  # GET /families/1/edit
  def edit
  end

  # GET /families/1/edit_family_member/2
  def edit_family_member
    @user = current_user
    @family_member = User.find(params[:member_id])

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


  # DELETE /families/:id/remove_member/:member_id
  def remove_member
    @removed_member_id = params[:member_id]
    @appointment = current_user.appointment_hosts.last
    family_member = User.find(@removed_member_id)
    family_member.destroy
    respond_to do |format|
      # format.html { redirect_to families_url, notice: 'Family was successfully destroyed.' }
      # format.json { head :no_content }
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
end
