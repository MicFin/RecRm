class PatientGroupsController < ApplicationController
  before_action :set_patient_group, only: [:show, :edit, :update, :destroy]

  # GET /patient_groups
  # GET /patient_groups.json
  def index
    @patient_groups = PatientGroup.all
  end

  # GET /patient_groups/1
  # GET /patient_groups/1.json
  def show
  end

  # GET /patient_groups/new
  def new
    @patient_group = PatientGroup.new
  end

  # GET /patient_groups/1/edit
  def edit
  end

  # POST /patient_groups
  # POST /patient_groups.json
  def create
    @patient_group = PatientGroup.new(patient_group_params)
    respond_to do |format|
      if @patient_group.save
        format.html { redirect_to @patient_group, notice: 'Recipe step was successfully created.' }
        format.json { render :show, status: :created, location: @patient_group }
      else
        format.html { render :new }
        format.json { render json: @patient_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patient_groups/1
  # PATCH/PUT /patient_groups/1.json
  def update
    respond_to do |format|
      if @patient_group.update(patient_group_params)
        format.html { redirect_to @patient_group, notice: 'Recipe step was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient_group }
      else
        format.html { render :edit }
        format.json { render json: @patient_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patient_groups/1
  # DELETE /patient_groups/1.json
  def destroy
    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to patient_groups_url, notice: 'Recipe step was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient_group
      @patient_group = PatientGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_group_params
      params.require(:patient_group).permit(:name, :category, :description, :order, :input_option)
    end
end
