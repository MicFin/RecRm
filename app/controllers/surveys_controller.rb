class SurveysController < ApplicationController
  before_filter :load_surveyable, only: [:index, :new, :create]
  before_action :set_survey, only: [:edit, :update]

  def index
    @surveys = @surveyable.surveys
  end

  def new
    
    if params[:survey_type] == "User-Food"
      # check for current surveys
      current_surveys = Survey.where(surveyable_id: @surveyable.id).where(survey_type: "User-Food")
      if current_surveys.count >= 1
        @survey = current_surveys.last
      else
        @survey = Survey.generate_for_user(current_user, @surveyable, "User-Food")
      end
    elsif params[:survey_type] == "User-Life"
      current_surveys = Survey.where(surveyable_id: @surveyable.id).where(survey_type: "User-Life")
      if current_surveys.count >= 1
        @survey = current_surveys.last
      else
        @survey = Survey.generate_for_user(current_user, @surveyable, "User-Life")
      end
    else
    end
    
    # @survey = @surveyable.surveys.new
    respond_to do |format|
      format.js 
    end
  end
    
  def create
    @survey = @surveyable.surveys.new(params[:survey])
    if @survey.save
      redirect_to @surveyable, notice: "survey created."
    else
      render :new
    end
  end

  def edit

  end

  def update
    
    update_questions_with_answers(params[:questions])
    respond_to do |format|
      if @survey.update(survey_params)
        
        format.html { redirect_to user_dashboard_path, notice: 'survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def update_questions_with_answers(questions_hash)
    ## save each question with the answer
    questions_hash.each do |question_id, answer|
      question = Question.find(question_id.to_i)
      question.answer = answer
      question.save
    end
  end

  def load_surveyable
    klass = [Appointment, User, PatientGroup].detect { |c| params["#{c.name.underscore}_id"]}
    @surveyable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def set_survey
    @survey = Survey.find(params[:id])
  end
    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:completed)
            # params.require(:survey).permit(:completed, :survey_type, :surveyable_id, :surveyable_type )
    end

end
