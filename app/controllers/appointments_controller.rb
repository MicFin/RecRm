class AppointmentsController < ApplicationController

  # HELPER METHODS
  include AppointmentsHelper
  include PatientGroupsHelper
  include FamiliesHelper

  before_action :set_appointment, only: [:show, :edit, :update, :purchase, :complete_appt_prep_survey, :select_time, :appointment_prep, :appointment_review, :update_duration, :end_appointment, :destroy, :client_appointment_prep]

  before_filter :config_opentok, :only => [:update]

  # GET /appointments
  # as: "appointments_path"
  def index

    #### user for user appointment nav tab
    if current_user 
      
      # AppointmentsHelper
      get_previous_appointments!
      @previous_appointments
      get_upcoming_appointment!
      @upcoming_appointment

      # FamiliessHelper
      get_family!
      @family
      @family_members = @family.family_members

    elsif ( (current_dietitian.has_role? "Admin Dietitian") && (params[:dietitian_id] == "All") ) 
      @appointments = Appointment.where("start_time > ?", DateTime.now).order('start_time ASC, created_at ASC')

    elsif ( (current_dietitian.has_role? "Admin Dietitian") && (params[:dietitian_id]) ) 
      dietitian = Dietitian.find(params[:dietitian_id])
      @appointments = dietitian.appointments.order('start_time ASC, created_at ASC')

    else

      @appointments_no_dietitian = {}
      @appointment_requests = {}

      Appointment.where("start_time > ?", DateTime.now - 1.days).order('start_time ASC, created_at ASC').where(dietitian_id: nil).each do |appointment|
          dietitians = appointment.available_dietitians
          @appointments_no_dietitian[appointment] = dietitians
      end
      
      # Appointment.where(status: "Requested").where("start_time > ?", DateTime.now - 1.days).order('start_time ASC, created_at ASC').each do |appointment|
      #   binding.pry
      #   if !@appointment_requests.has_key?(appointment.appointment_host)
      #     @appointment_requests[appointment.appointment_host] = []
      #   end
      #   @appointment_requests[appointment.appointment_host] << appointment
      # end

      @upcoming_appointments = Appointment.where("start_time > ?", DateTime.now).order('start_time ASC, created_at ASC')
      @previous_appointments = Appointment.where("start_time < ?", DateTime.now).order('start_time ASC, created_at ASC')
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json

  # this is where the index modal is coming from to view the prep information before the admin assigns a dietitian to an appointment
  def show

    if params[:data] == "Request"
      
    else 
      ### this is being used to prep assign the dietitian 
      @dietitians = @appointment.available_dietitians
      @dietitians_data = {}
      @dietitians.each do |dietitian|
        @dietitians_data[dietitian] = {}
        @dietitians_data[dietitian]["half_hour_time_slots_available"] = dietitian.half_hour_time_slots_available
        @dietitians_data[dietitian]["loss_time_slots"] = dietitian.loss_time_slots(@appointment) 
        @dietitians_data[dietitian]["loss_cal_slots"] = dietitian.loss_calendar_slots(@appointment)      
      end
      #@survey = @appointment.surveys.where(survey_type: "Pre-Appointment-Client").last
    end

    respond_to do |format|
      format.js
    end
  end

  # GET /appointments/new
  def new
    binding.pry
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
    ## if the appointment status is follow up unpaid and does not have a stripe card token then the appointment is being created without payment and the dates need to be cleaned
    if @appointment.status == "Follow Up Unpaid" && params[:appointment][:stripe_card_token] == nil
      clean_dates_for_database
      # @appointment.update(appointment_params) # used this to update dietitian when being assigned
      
      # create room shoudl remove
      @new_session = @opentok.create_session 
      @tok_token = @new_session.generate_token :session_id =>@new_session.session_id 
      ## creating a new room each time, should either purge old rooms or assign rooms to dietitians 
      @new_room = Room.new(dietitian_id:  @appointment.dietitian_id, public: true, sessionId: @new_session.session_id, name: "Early Access Session")
      @new_room.save
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

    elsif @appointment.update(appointment_params)
      

      # or when admin dietitian assigns dietitian
      if (@appointment.dietitian_id != nil)
        ## assumes that appointment has been paid for and assigned a dietitian by admin dietitian
        
        @new_session = @opentok.create_session 
        @tok_token = @new_session.generate_token :session_id =>@new_session.session_id 
        ## creating a new room each time, should either purge old rooms or assign rooms to dietitians 
        @new_room = Room.new(dietitian_id:  @appointment.dietitian_id, public: true, sessionId: @new_session.session_id, name: "Appointment")
        @new_room.save
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
        TimeSlot.where(start_time: @appointment.start_time).where(end_time: @appointment.end_time).each do |ts|
          if ts.dietitian == @appointment.dietitian
            time_slot = ts 
            time_slot.vacancy = false
            time_slot.status = "Appointment"
            time_slot.appointment = @appointment
            time_slot.save
            TimeSlot.cancel_related_time_slots(time_slot)
          end
        end
 

      # other updates that could happen
      else

         
      end
    end
    
    respond_to do |format|
      if @appointment.save
        if current_dietitian 
          format.html { redirect_to appointments_path(current_dietitian), notice: 'Appointment was successfully created.' }
          format.json { render :show, status: :ok, location: @appointment }
          format.js
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

  # GET /appointments/:id/select_time
  # as: 'select_time_path'
  def select_time
    @time_slots = TimeSlot.select_appointment_time_slots 
    @sign_up_stage = @appointment.stage 
    @appointment_requests = Appointment.where(appointment_host_id: current_user.id).where(status: "Requested").order('start_time ASC, created_at ASC')
  end

  # GET /appointments/:id/appointment_prep
  # as: 'appointment_prep_path'
  # currently called from dietitian prep and dietitian insession as well
  def appointment_prep
   
    # should add the .has_role? to "Current Dietitian" in here so the dietitian doesnt haveunlimited access
    @survey = @appointment.surveys.where(survey_group_id: 1).first

    @client = @appointment.appointment_host

    # Gather user's family data
    # from AppointmentsHelper
    get_appointment_family_info!
    @family

    @dietitian_survey = Survey.generate_for_appointment(@appointment, @appointment.dietitian)

    respond_to do |format|
      format.html
      format.js
    end
  end


  # GET /appointments/:id/client_appointment_prep
  # as: 'client_appointment_prep_path'
  def client_appointment_prep
    patient_focus = @appointment.patient_focus
    growth_chart = patient_focus.growth_chart || GrowthChart.create(user_id: patient_focus.id)
    food_diary = patient_focus.food_diary || FoodDiary.create(user_id: patient_focus.id)
    survey = Survey.generate_for_appointment(@appointment, current_user)
    food_diary_entry = FoodDiaryEntry.new(food_diary_id: food_diary.id)
    growth_entry = GrowthEntry.new(growth_chart_id: growth_chart.id)
    @client_prep = {growth_chart: growth_chart, food_diary: food_diary, survey: survey, food_diary_entry: food_diary_entry, growth_entry: growth_entry}
    
    respond_to do |format|
      format.js 
    end
  end

  # GET /appointments/1/edit_assessment  
  # as: 'edit_assessment_path'
  def edit_assessment
   # should add the .has_role? to "Current Dietitian" in here so the dietitian doesnt haveunlimited access
    # @survey = @appointment.surveys.where(survey_group_id: 1).first
    if @appointment.dietitian == current_dietitian 
      @client = @appointment.appointment_host

      # Gather user's family data
      # from AppointmentsHelper
      get_appointment_family_info!
      @family

      @dietitian_survey = Survey.generate_for_appointment(@appointment, @appointment.dietitian)

      
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /appointments/:id/complete_appt_prep_survey
  # as: 'user_complete_appt_prep_survey_path'
  def complete_appt_prep_survey
    @appointment.status = "Appt-Prep-Survey-Complete"
    @appointment.save
  end
  
  # GET /appointments/1/appointment_review
  # Used by admin dietitian to assign dietitian
  def appointment_review
    # should add the .has_role? to "Current Dietitian" in here so the dietitian doesnt haveunlimited access
    
    if @appointment.dietitian == current_dietitian 
      @client = @appointment.appointment_host
      # set @family before get_family_info
      @family = @client.head_of_families.first
      # get_family_info!
      # @family_members
      # @family
      # create family should be a helper method on the family model
      @family_members = []
      if @appointment.patient_focus 
        appointment_focus = @appointment.patient_focus
        @family_members << appointment_focus
      end
      family_count = @family.users.count
      
      if family_count > 0
        if @client != appointment_focus
          @family_members << @client
          @family.users.each do |family_member| 
            if family_member != appointment_focus
              @family_members << family_member 
            end
          end
        else
          @family.users.each do |family_member|
              @family_members << family_member
          end
        end
      else
        @family_members << @client
      end
      get_patient_groups!
      @diseases = @diseases 
      @intolerances = @intolerances 
      @allergies = @allergies
      @diets =  @diets 
      # @unverified_health_groups = @family_members[0].unverified_health_groups
      @dietitian_survey = Survey.generate_for_appointment(@appointment, current_dietitian)
      @survey = Survey.generate_for_appointment(@appointment, @appointment.appointment_host)
      @surveyable = @appointment
    end
    respond_to do |format|
      format.js
    end
  end

  # Use this for when an appointment is not paid for and but is assigned to a client
  def purchase
    
    @user = current_user
    # payment_modal template requires a time_slot for start and end time
    @time_slot = @appointment 
    respond_to do |format|
      format.js
      format.html
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
        # @survey = Survey.generate_for_post_appointment(@appointment, current_user)
        # return user end of apt survey
        
          format.html { redirect_to user_authenticated_root_path, notice: 'Appointment was successfully completed.' }
          format.js
        
      else
        # else a dietitian
        #  dietitian end of appointment survey
        # @survey = Survey.generate_for_post_appointment(@appointment, current_dietitian)
        # @follow_up = Survey.generate_for_follow_up(@appointment)

        # mark appointment as complete, timestamp ending time, save length
        @appointment.status = "Complete"
        @appointment.save
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
  
    def clean_dates_for_database
      
      ## clean start date for saving
      if params[:appointment][:start_time]
        temp_start_date = params[:appointment][:start_time].split("/")
        temp_start_month = temp_start_date[0]
        temp_start_day = temp_start_date[1]
        temp_start_year = temp_start_date[2].split(" ")[0]
        params[:appointment][:start_time] = temp_start_year +"/"+temp_start_month+"/"+temp_start_day+" "+temp_start_date[2].split(" ", 2)[1].delete(' ')
        params[:appointment][:start_time] = params[:appointment][:start_time].in_time_zone("Eastern Time (US & Canada)")
        ## clean end date for saving
        temp_end_date = params[:appointment][:end_time].split("/")
        temp_end_month = temp_end_date[0]
        temp_end_day = temp_end_date[1]
        temp_end_year = temp_end_date[2].split(" ")[0]
        params[:appointment][:end_time] = temp_end_year +"/"+temp_end_month+"/"+temp_end_day+" "+temp_end_date[2].split(" ", 2)[1].delete(' ')
        params[:appointment][:end_time] = params[:appointment][:end_time].in_time_zone("Eastern Time (US & Canada)")
        
      else
        
      ## clean start date for saving
        temp_start_date = value_hash["start_time"].split("/")
        temp_start_month = temp_start_date[0]
        temp_start_day = temp_start_date[1]
        temp_start_year = temp_start_date[2].split(" ")[0]
        value_hash["start_time"] = temp_start_year +"/"+temp_start_month+"/"+temp_start_day+" "+temp_start_date[2].split(" ", 2)[1].delete(' ')
        value_hash["start_time"] = value_hash["start_time"].in_time_zone("Eastern Time (US & Canada)")

        ## clean end date for saving
        temp_end_date = value_hash["end_time"].split("/")
        temp_end_month = temp_end_date[0]
        temp_end_day = temp_end_date[1]
        temp_end_year = temp_end_date[2].split(" ")[0]
        value_hash["end_time"] = temp_end_year +"/"+temp_end_month+"/"+temp_end_day+" "+temp_end_date[2].split(" ", 2)[1].delete(' ')
        value_hash["end_time"] = value_hash["end_time"].in_time_zone("Eastern Time (US & Canada)")
      end
    end

    def config_opentok
      
      if @opentok.nil?
       @opentok = OpenTok::OpenTok.new ENV["API_KEY"], ENV["API_SECRET"]
      end
    end
end
