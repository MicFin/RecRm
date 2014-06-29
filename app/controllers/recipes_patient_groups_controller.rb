class RecipesPatientGroupsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :set_recipes_patient_group, only: [:show, :edit, :update, :destroy]


  # GET /recipes_patient_groups
  # GET /recipes_patient_groups.json
  def index
    @recipes_patient_groups = RecipesPatientGroup.all
  end

  # GET /recipes_patient_groups/1
  # GET /recipes_patient_groups/1.json
  def show
  end

  # GET /recipes_patient_groups/new
  def new
    @recipes_patient_group = RecipesPatientGroup.new
  end

  # GET /recipes_patient_groups/1/edit
  def edit
  end

  # POST /recipes_patient_groups
  # POST /recipes_patient_groups.json
  def create
    @recipes_patient_group = RecipesPatientGroup.new(recipes_patient_group_params)
    respond_to do |format|
      if @recipes_patient_group.save
        # need to redirect somwhere........
        format.html { redirect_to @recipes_patient_group, notice: 'recipes_patient_group was successfully created.' }
        format.json { render :show, status: :created, location: @recipes_patient_group }
        # we are responding to JS right now, create.js.erb
        format.js 
      else
        format.html { render :new }
        format.json { render json: @recipes_patient_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes_patient_groups/1
  # PATCH/PUT /recipes_patient_groups/1.json
  def update
    respond_to do |format|
      if @recipes_patient_group.update(recipes_patient_group_params)
        format.html { redirect_to @recipes_patient_group, notice: 'recipes_patient_group was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipes_patient_group }
      else
        format.html { render :edit }
        format.json { render json: @recipes_patient_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes_patient_groups/1
  # DELETE /recipes_patient_groups/1.json
  def destroy
    @recipes_patient_group.destroy
    respond_to do |format|
      format.html { redirect_to recipes_patient_groups_url, notice: 'recipes_patient_group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipes_patient_group
      @recipes_patient_group = RecipesPatientGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipes_patient_group_params
      params.require(:recipes_patient_group).permit(:patient_group_id, :recipe_id )
    end
end
