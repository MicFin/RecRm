# == Schema Information
#
# Table name: rooms
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  sessionId    :string(255)
#  public       :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  dietitian_id :integer
#

class RoomsController < ApplicationController
  include PatientGroupsHelper
  before_filter :config_opentok,:except => [:index]
  # only admin can view rooms index page
  before_filter :authenticate_admin_user!, only: [:index]

  # Force SSL for rooms, TokBox plugin requires it
  force_ssl unless Rails.env.development?
  
  def index
    @rooms = Room.where(:public => true).order("created_at DESC")
    @new_room = Room.new
  end

  def create
    #commented out to trouble shoot, could add in
    # session = @opentok.create_session request.remote_addr
    @new_session = @opentok.create_session 
    params[:room][:sessionId] = @new_session.session_id
    @tok_token = @new_session.generate_token :session_id =>@new_session.session_id  
    @new_room = Room.new(params[:room])
    respond_to do |format|
      if @new_room.save
        format.html { redirect_to("/session/"+@new_room.id.to_s) }
      else
        format.html { render :controller => 'rooms',
          :action => "index" }
      end
    end
  end

  def in_session
    
    # Set room
    @room = Room.find(params[:id])

    # Set appointment
    # Could also do @room.appointments but could have multiple appointments
    # Need to decide room construct 1 per dietitian? per session? what?
    @appointment = Appointment.find(params[:appointment])
    
    # Get client pre appointment survey
    # Not done well, just grabs last one
    # @survey = @appointment.surveys.where(survey_type: "Pre-Appointment-Client").where(completed: true).last

    # # Set surveyable
    # @surveyable = @appointment

    # Different user types require specific variables for a room
    # Check user type and create variables
    if current_admin_user

      # Set @user to current admin
      @user = current_admin_user

    elsif current_dietitian

      # Set @user to current dietitian
      @user = current_dietitian

      # Set client 
      @client = @appointment.appointment_host

      # appointment_host = @appointment.appointment_host

      # Generate tokbox token
      @tok_token =  @opentok.generate_token(@room.sessionId, {role: :moderator, data: "Moderator"}) 
      # @tok_token =  @opentok.generate_token @room.sessionId({
      #   :role        => :moderator
      #   :expire_time => Time.now.to_i+(7 * 24 * 60 * 60) # in one week
      #   :data        => 'name=Johnny'
      # });

      # # Get dietitian pre appointment survey
      # @dietitian_pre_appt_survey = @appointment.surveys.where(survey_type: "Pre-Appointment-Dietitian").where(completed: true).last.questions.order("position")

      ## Create new appointment for dietitian to schedule if needed
      ## should probably use AJAX to call appointment controller for this info
      @new_appointment = Appointment.new(dietitian_id: current_dietitian.id, appointment_host_id: @client.id, patient_focus_id: @appointment.patient_focus_id, status: "Follow Up Unpaid")

      # These might not be necessary since called via ajax
      @survey = Survey.generate_for_session(@appointment, @user)
      @pre_appt_survey = Survey.generate_for_appointment(@appointment, @client)
      @family = Families::FamilyPresenter.new(@client.head_of_families.first)
    # else is a client_in_session
    else

      # Set @user to current user
      @user = current_user

      # Generate tokbox token
      @tok_token =  @opentok.generate_token @room.sessionId 

      # Get dietitian for appointment
      @dietitian = @appointment.dietitian

      # These might not be necessary since called via ajax
      @survey = Survey.generate_for_session(@appointment, @user)
      @pre_appt_survey = Survey.generate_for_appointment(@appointment, @user)
      @surveyable = @appointment
      @family = Families::FamilyPresenter.new(@user.head_of_families.first)
    end
    
  end

  private
  def config_opentok
    if @opentok.nil?
     @opentok = OpenTok::OpenTok.new ENV["API_KEY"], ENV["API_SECRET"]
    end
  end


end
