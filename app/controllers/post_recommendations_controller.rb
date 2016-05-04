class PostRecommendationsController < ApplicationController
  before_action :set_post_recommendation, only: [:edit, :update, :destroy]

  # GET /post_recommendations/new
  def new
    user_id = params[:user_id]
    dietitian_id = current_dietitian.id
    appointment_id = params[:appointment_id]
    monologue_post_id = params[:monologue_post_id] 
    if appointment_id
      @post_recommendation = PostRecommendation.new(monologue_post_id: monologue_post_id, user_id: user_id, dietitian_id: dietitian_id, appointment_id: appointment_id)

      @appointment = Appointments::AppointmentPresenter.new(Appointment.find(appointment_id))
      @family = Families::FamilyPresenter.new(@appointment.appointment_host.head_of_families.first)
    else
      @post_recommendation = PostRecommendation.new(monologue_post_id: monologue_post_id, user_id: user_id, dietitian_id: dietitian_id)
    end
    respond_to do |format|
        # format.html
        format.js
    end
  end

  def create
    
    @post_recommendation = PostRecommendation.new(post_recommendation_params)
    
    respond_to do |format|
      if @post_recommendation.save
        # if @post_recommendation.appointment_id 
          appointment = Appointment.find(@post_recommendation.appointment_id)
          format.html { redirect_to appointment, notice: 'Recommendation saved!' }
        # else
        # end
      else
        format.html { render :new }
        # format.json { render json: @post_recommendation.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

    respond_to do |format|
      format.js
      # format.html
    end
  end

  def update
    
    respond_to do |format|
      if @post_recommendation.update(post_recommendation_params)
        # if @post_recommendation.appointment_id 
          appointment = Appointment.find(@post_recommendation.appointment_id)
          format.html { redirect_to appointment, notice: 'Recommendation updated!' }
        # else
        # end
      else
        format.html { render :edit }
        # format.json { render json: @post_recommendation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    appointment = Appointment.find(@post_recommendation.appointment_id)
    @post_recommendation.destroy
    respond_to do |format|
      format.html { redirect_to appointment, notice: 'Recommendation removed.' }
      # format.js
    end
  end

  def posts
    appointment_id = params[:appointment_id]

    if appointment_id 
      @appointment = Appointments::AppointmentPresenter.new(Appointment.find(appointment_id))
    end
    @posts = Monologue::Post.all.includes_users
    @tags = Monologue::Tag.all
    respond_to do |format|
        format.html
        format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_recommendation
      @post_recommendation = PostRecommendation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_recommendation_params
      params.require(:post_recommendation).permit(:dietitian_id, :user_id, :appointment_id, :monologue_post_id, :message, :recommendation_type)
    end


end
