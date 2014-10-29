class RoomsController < ApplicationController
before_filter :config_opentok,:except => [:index]
# only admin can view rooms pages
before_filter :authenticate_admin_user!, only: [:index]

  def index
    @rooms = Room.where(:public => true).order("created_at DESC")
    @new_room = Room.new
  end

  def create
    #commented out to trouble shoot, could add in
    # session = @opentok.create_session request.remote_addr
    @new_session = @opentok.create_session 
    params[:room][:sessionId] = @new_session.session_id
    @new_room = Room.new(params[:room])
    @tok_token = @new_session.generate_token :session_id =>@new_session.session_id  
    respond_to do |format|
      if @new_room.save
        format.html { redirect_to("/session/"+@new_room.id.to_s) }
      else
        format.html { render :controller => 'rooms',
          :action => "index" }
      end
    end
  end

  def session
    @room = Room.find(params[:id])
    @tok_token =  @opentok.generate_token Room.find(params[:id]).sessionId  
    @appointment = Appointment.find(params[:appointment])
    if current_user
      @user = current_user
    elsif current_dietitian
      @user = current_dietitian
      # @tech_survey_questions = Survey.where(id: 2).first.questions 
      # @tech_survey_responses = @appointment.appointment_host.user_surveys.where(survey_id: 2).last.user_survey_answers
      # @appt_survey_questions = Survey.where(id: 1).first.questions 
      # @appt_survey_responses = @appointment.appointment_host.user_surveys.where(survey_id: 1).last.user_survey_answers
    elsif current_admin_user
      @user = current_admin_user
      # @tech_survey_questions = Survey.where(id: 2).first.questions 
      # # @tech_survey_responses = @appointment.appointment_host.user_surveys.where(survey_id: 2).last.user_survey_answers
      # @appt_survey_questions = Survey.where(id: 1).first.questions 
      # @appt_survey_responses = @appointment.appointment_host.user_surveys.where(survey_id: 1).last.user_survey_answers
    end
  end

  private
  def config_opentok
    if @opentok.nil?
     @opentok = OpenTok::OpenTok.new ENV["API_KEY"], ENV["API_SECRET"]
    end
  end


end
