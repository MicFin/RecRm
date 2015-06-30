class FamiliesController < ApplicationController
  before_action :set_family, only: [:show, :edit, :update, :destroy]

  # GET /families
  # GET /families.json
  def index
    @families = Family.all
  end

  # GET /families/1
  # GET /families/1.json
  def show
    @user = current_user
    @family_members = @family.users 
    @family_members << @family.head_of_family
  end

  # GET /families/new
  def new
    @user = current_user
    @family = Family.new
    @family.users.build
    @new_user = User.new(last_name: @user.last_name)
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /families/1/edit
  def edit
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
