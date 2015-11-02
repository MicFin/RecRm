class SurveyGroupsController < ApplicationController
  before_action :set_survey_group, only: [:show, :edit, :update, :destroy]

  # GET /survey_groups
  # GET /survey_groups.json
  def index
    @survey_groups = SurveyGroup.all
  end

  # GET /survey_groups/1
  # GET /survey_groups/1.json
  def show
  end

  # GET /survey_groups/new
  def new
    @survey_group = SurveyGroup.new
  end

  # GET /survey_groups/1/edit
  def edit
  end

  # POST /survey_groups
  # POST /survey_groups.json
  def create
    @survey_group = SurveyGroup.new(survey_group_params)

    respond_to do |format|
      if @survey_group.save
        format.html { redirect_to @survey_group, notice: 'Survey group was successfully created.' }
        format.json { render :show, status: :created, location: @survey_group }
      else
        format.html { render :new }
        format.json { render json: @survey_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /survey_groups/1
  # PATCH/PUT /survey_groups/1.json
  def update
    respond_to do |format|
      if @survey_group.update(survey_group_params)
        format.html { redirect_to @survey_group, notice: 'Survey group was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey_group }
      else
        format.html { render :edit }
        format.json { render json: @survey_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /survey_groups/1
  # DELETE /survey_groups/1.json
  def destroy
    @survey_group.destroy
    respond_to do |format|
      format.html { redirect_to survey_groups_url, notice: 'Survey group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey_group
      @survey_group = SurveyGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_group_params
      params.require(:survey_group).permit(:name, :version_number)
    end
end
