# == Schema Information
#
# Table name: questions
#
#  id              :integer          not null, primary key
#  question_type   :string(255)
#  content         :text
#  position        :integer
#  choices         :text
#  tier            :integer          default(1)
#  created_at      :datetime
#  updated_at      :datetime
#  survey_group_id :integer
#

class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_survey_group, only: [:new, :edit, :update, :create, :destroy]

  # GET /survey_groups/:survey_group_id/questions
  # GET /survey_groups/:survey_group_id/questions.json
  def index
    @questions = Question.all
  end

  # GET /survey_groups/:survey_group_id/questions/1
  # GET /survey_groups/:survey_group_id/questions/1.json
  def show
  end

  # GET /survey_groups/:survey_group_id/questions/new
  def new
    @question = Question.new
  end

  # GET /survey_groups/:survey_group_id/questions/1/edit
  def edit
  end

  # POST /survey_groups/:survey_group_id/questions
  # POST /survey_groups/:survey_group_id/questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to edit_survey_group_path(@survey_group), notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /survey_groups/:survey_group_id/questions/1
  # PATCH/PUT /survey_groups/:survey_group_id/questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to edit_survey_group_path(@survey_group), notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /survey_groups/:survey_group_id/questions/1
  # DELETE /survey_groups/:survey_group_id/questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to edit_survey_group_path(@survey_group), notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    def set_survey_group
      @survey_group = SurveyGroup.find(params[:survey_group_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
    params.require(:question).permit( :question_type, :content, :position, :survey_group_id, :choices , :tier)
    end
end
