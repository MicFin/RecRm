# == Schema Information
#
# Table name: appointments
#
#  id                  :integer          not null, primary key
#  patient_focus_id    :integer
#  appointment_host_id :integer
#  dietitian_id        :integer
#  room_id             :integer
#  note                :text
#  client_note         :text
#  created_at          :datetime
#  updated_at          :datetime
#  start_time          :datetime
#  end_time            :datetime
#  stripe_card_token   :string(255)
#  regular_price       :integer
#  invoice_price       :integer
#  duration            :integer
#  other_note          :text
#  time_slot_id        :integer
#  status              :string(255)
#  registration_stage  :integer          default(0)
#  client_prepped      :boolean
#  dietitian_prepped   :boolean
#

class AppointmentsController < ApplicationController

  # # HELPER METHODS
  include AppointmentsHelper
  include PatientGroupsHelper
  include FamiliesHelper

  # # CALL BACKS
  before_action :set_appointment, only: [:show, :edit, :update, :destroy, :update_duration, :purchase, :assign_dietitian, :appointment_prep, :client_appointment_prep, :end_appointment, :summary]
  before_filter :config_opentok, :only => [:assign_dietitian]

  # GET /appointments
  # as: "appointments_path"
  # Admin Dietitian Appointments Dashboard
  def index

    @appointments_no_dietitian = {}

    # Get current unassigned appointments and the dietitians available to see them
    Appointment.upcoming_and_current.unassigned.includes(:appointment_host).by_start_time.each do |appointment|
        @appointments_no_dietitian[Appointments::AppointmentPresenter.new(appointment)] = appointment.available_dietitians
    end

    # Get all upcoming and scheduled appointments
    @upcoming_appointments = Appointments::AppointmentPresenter.present(Appointment.upcoming_and_current.scheduled.includes(:appointment_host).includes(:patient_focus).includes(:dietitian).by_start_time)

    # Get all previous and completed appointments
    @previous_appointments = Appointments::AppointmentPresenter.present(Appointment.previous.complete.includes(:appointment_host).includes(:patient_focus).includes(:dietitian).by_start_time)
    
  end


  # GET /appointments/1
  # GET /appointments/1.json
  # this is where the index modal is coming from to view the prep information before the admin assigns a dietitian to an appointment
  def show

    @surveyable = Appointments::AppointmentPresenter.new(@appointment)

    @client_prep_survey = Survey.generate_for_appointment(@surveyable, @surveyable.appointment_host)
    @client_notes = Survey.generate_for_session(@surveyable, @surveyable.appointment_host)
    @client_nps_survey = Survey.generate_for_post_appointment(@surveyable, @surveyable.appointment_host)

    @dietitian_prep_survey = Survey.generate_for_appointment(@surveyable, @surveyable.dietitian)
    @dietitian_notes = Survey.generate_for_session(@surveyable, @surveyable.dietitian)
    @dietitian_nps_survey = Survey.generate_for_post_appointment(@surveyable, @surveyable.dietitian)
    @assessment = Survey.generate_for_assessment(@surveyable, @surveyable.appointment_host)
    @provider_assessment = Survey.generate_for_assessment(@surveyable, @surveyable.dietitian)

    @family = Families::FamilyPresenter.new(@surveyable.appointment_host.head_of_families.first)
    
    @recommendations = @surveyable.monologue_posts

    # if params[:data] == "Request"
      
    # else 
    #   ### this is being used to prep assign the dietitian 
    #   @dietitians = @appointment.available_dietitians
      
    #   @dietitians_data = {}
    #   @dietitians.each do |dietitian|
    #     @dietitians_data[dietitian] = {}
    #     # @dietitians_data[dietitian]["half_hour_time_slots_available"] = dietitian.half_hour_time_slots_available
    #     # @dietitians_data[dietitian]["loss_time_slots"] = dietitian.loss_time_slots(@appointment) 
    #     # @dietitians_data[dietitian]["loss_cal_slots"] = dietitian.loss_calendar_slots(@appointment)      
    #   end

    #   #@survey = @appointment.surveys.where(survey_type: "Pre-Appointment-Client").last
    # end
    # @appointment = Appointments::AppointmentPresenter.new(@appointment)
    # respond_to do |format|
    #   format.js
    # end
  end

  # GET /appointments/new
  def new
    
    @appointment = Appointment.new
  end

  # POST /appointments
  # POST /appointments.json
  def create
    
    clean_dates_for_database
    
    @appointment = Appointment.new(appointment_params)
    
    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
        format.js
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /appointments/1/edit
  def edit

    # should have both variables
    @appointment = Appointments::AppointmentPresenter.new(@appointment)
   
    if @appointment.status == "Follow Up Unpaid"
      # unpaid appointment that is edited after a dietitian creates the follow up unpaid appointment
      # set new_appointment variable for next_session_form.html.erb
      @new_appointment = @appointment

    else

      # unknown scenario
      @dietitians = Dietitian.all 
    end
  
    @user = current_user  

    respond_to do |format|
      format.js
      format.html
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update

    # clean_dates_for_database(time_zone)
    add_time_zone_to_input


    respond_to do |format|
      if @appointment.update(appointment_params)
        if current_dietitian 
          format.html { redirect_to appointments_path(current_dietitian), notice: 'Appointment was successfully created.' }
          format.json { render :show, status: :ok, location: @appointment }
          format.js
        # not sure when non-dietitian user is updating appointment yet
        else
          format.html { redirect_to welcome_home_path, notice: 'Appointment was successfully created.' }
          format.json { render :show, status: :ok, location: @appointment }
          format.js
        end
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @new_appointment = Appointment.new(dietitian_id: current_dietitian.id, appointment_host_id: @appointment.appointment_host_id, patient_focus_id: @appointment.patient_focus_id, status: "Follow Up Unpaid")
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }

      format.js
    end
  end

  # PATCH/PUT /appointments/1/assign_dietitian
  # Assign dietitian and create room
  def assign_dietitian

    # if can save with dietitian
    if @appointment.update(appointment_params)
    
      # create a tokbox session and room
      @new_session = @opentok.create_session 
      @tok_token = @new_session.generate_token :session_id =>@new_session.session_id 
      # creating a new room each time, should either purge old rooms or assign rooms to dietitians 
      @new_room = Room.new(dietitian_id:  @appointment.dietitian_id, public: true, sessionId: @new_session.session_id, name: "Appointment")
      @new_room.save
      # assign roles to room
      dietitian = @appointment.dietitian
      dietitian.add_role "Session Host", @new_room
      user = @appointment.appointment_host
      user.add_role "Session Guest", @new_room
      user.save

      # set appointment to room (1st and only for now)
      if @appointment.room_id == nil
        @appointment.room_id = @new_room.id
        @appointment.save
      end

       # mark time slot as having an appointment and cancel related time slots
      time_slot = TimeSlot.starts_at(@appointment.start_time).ends_at(@appointment.end_time).for_dietitian(@appointment.dietitian_id).first
      time_slot.vacancy = false
      time_slot.status = "Appointment"
      time_slot.appointment = @appointment
      time_slot.save
      TimeSlot.cancel_related_time_slots(time_slot)
    end
 
    # Generate KRDN Pre Appointment Prep
    Survey.generate_for_appointment(@appointment, @appointment.dietitian)

    # return to appointments path
    respond_to do |format|
      if @appointment.save
          format.html { redirect_to appointments_path, notice: 'KRDN was successfully assigned.' }
          format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end


  
  # Update duration of appointment, used when client is searching for an appointment
  def update_duration

   # update the appointment's duration
    @appointment.update_attribute(:duration, params[:appointment][:duration])

    # get original page where appointment was updated from
    session[:return_to] ||= request.referer

    respond_to do |format|

      # update_time_zone.js replace calendar with new events based on updated time zone
      format.js

      # redirect back to original page where time zone was updated
      format.html { redirect_to session.delete(:return_to) }
    end
  end


  # GET /appointments/1/end_appointment
  # Should move to another controller, maybe the rooms_controller
  def end_appointment

    respond_to do |format|
      if current_user 

        # if a user
        @survey = Survey.generate_for_post_appointment(@appointment, current_user)
        @survey_group = @survey.survey_group.name
        # return user end of apt survey
        
          format.html { redirect_to user_authenticated_root_path, notice: 'Appointment was successfully completed.' }
          format.js
        
      else

        @survey = Survey.generate_for_post_appointment(@appointment, current_dietitian)
        @survey_group = @survey.survey_group.name
        # mark appointment as complete
        if params[:data] && params[:data][:end_session] === "true"
          @appointment.status = "Complete"
          @appointment.save
        end
        # @user_pre_appt_survey = Survey.generate_for_appointment(@appointment, @appointment.appointment_host)
        # # 
          format.html { redirect_to dietitian_authenticated_root_path, notice: 'Appointment was successfully completed.' }
          format.js
        
      end
    end

  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:patient_focus_id, :appointment_host_id, :dietitian_id, :start_time, :end_time, :room_id, :note, :client_note, :other_note, :created_at, :updated_at, :status, :time_slot_id, :stripe_card_token, :duration)
    end

    def add_time_zone_to_input
      current_user ? time_zone = current.time_zone : time_zone = "Eastern Time (US & Canada)"
      params[:appointment][:end_time] = params[:appointment][:end_time].in_time_zone(time_zone)
      params[:appointment][:start_time] = params[:appointment][:start_time].in_time_zone(time_zone)
    end

    def clean_dates_for_database(time_zone)
      
      ## clean start date for saving
      if params[:appointment][:start_time]
        temp_start_date = params[:appointment][:start_time].split("/")
        temp_start_month = temp_start_date[0]
        temp_start_day = temp_start_date[1]
        temp_start_year = temp_start_date[2].split(" ")[0]
        params[:appointment][:start_time] = temp_start_year +"/"+temp_start_month+"/"+temp_start_day+" "+temp_start_date[2].split(" ", 2)[1].delete(' ')
        params[:appointment][:start_time] = params[:appointment][:start_time].in_time_zone(time_zone)
        ## clean end date for saving
        temp_end_date = params[:appointment][:end_time].split("/")
        temp_end_month = temp_end_date[0]
        temp_end_day = temp_end_date[1]
        temp_end_year = temp_end_date[2].split(" ")[0]
        params[:appointment][:end_time] = temp_end_year +"/"+temp_end_month+"/"+temp_end_day+" "+temp_end_date[2].split(" ", 2)[1].delete(' ')
        params[:appointment][:end_time] = params[:appointment][:end_time].in_time_zone(time_zone)
        
      else
        
      ## clean start date for saving
        temp_start_date = value_hash["start_time"].split("/")
        temp_start_month = temp_start_date[0]
        temp_start_day = temp_start_date[1]
        temp_start_year = temp_start_date[2].split(" ")[0]
        value_hash["start_time"] = temp_start_year +"/"+temp_start_month+"/"+temp_start_day+" "+temp_start_date[2].split(" ", 2)[1].delete(' ')
        value_hash["start_time"] = value_hash["start_time"].in_time_zone(time_zone)

        ## clean end date for saving
        temp_end_date = value_hash["end_time"].split("/")
        temp_end_month = temp_end_date[0]
        temp_end_day = temp_end_date[1]
        temp_end_year = temp_end_date[2].split(" ")[0]
        value_hash["end_time"] = temp_end_year +"/"+temp_end_month+"/"+temp_end_day+" "+temp_end_date[2].split(" ", 2)[1].delete(' ')
        value_hash["end_time"] = value_hash["end_time"].in_time_zone(time_zone)
      end
    end

    def config_opentok
      
      if @opentok.nil?
       @opentok = OpenTok::OpenTok.new ENV["API_KEY"], ENV["API_SECRET"]
      end
    end
end
