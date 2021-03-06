# == Schema Information
#
# Table name: time_slots
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  start_time      :datetime
#  end_time        :datetime
#  created_at      :datetime
#  updated_at      :datetime
#  minutes         :integer
#  status          :string(255)
#  availability_id :integer
#  vacancy         :boolean          default(TRUE)
#

class TimeSlotsController < ApplicationController

  # # CALL BACKS
  before_action :set_time_slot, only: [:show, :edit, :update, :create_from_existing, :destroy]

  # GET /time_slots
  # GET /time_slots.json, created for calendar usage
  def index

    # If it is a dietitian, currently used for Admin Dietitian to review available time slots across company
    # Not currently using 
    if current_dietitian
      
      @time_slots = TimeSlot.current.vacant.half_hour.by_start_time

    # Else it is current_user scheduling an appointment to select a time slot  
    else
      
      # Set duration to the duration of the appointment or default to 60
      duration = current_user.appointment_in_registration.duration || 60

      # Set dietitian or to blank for all dietitians
      dietitian_id = params[:dietitian_id] || ""

      # If empty string then show all dietitians
      if dietitian_id != ""
        # filter for Current 
        # filter for Vacant
        # filter for Duration 
        # filter for 2 day buffer
        # filter for specific deititian
        @time_slots = TimeSlot.current.vacant.has_length(duration).upcoming_with_buffer(2).for_dietitian(dietitian_id)

      # Else if filter dietitian by expertise is turned on
      elsif KfConfig["general.matching.filter_expertises"] == "on"
        @time_slots =[]
        # filter for expertise with dietitian qualification above 0
        # filter for expertise in patient group of 
        qualified_dietitians = Dietitian.includes(:expertises => :patient_group).where(["expertises.dietitian_qualification > ?", 0]).where(patient_groups: {id: current_user.appointment_in_registration.patient_focus.patient_groups.map(&:id)})

        qualified_dietitians.each do |dietitian|
          # filter for Current 
          # filter for Vacant
          # filter for Duration 
          # filter for 2 day buffer
          # filter for qualified deititian
          @time_slots << TimeSlot.current.vacant.has_length(duration).upcoming_with_buffer(2).for_dietitian(dietitian.id)
        end

      # Else any dietitian
      else
        # filter for Current 
        # filter for Vacant
        # filter for Duration 
        # filter for 2 day buffer
        # filter for dietitian emptry string ""
        @time_slots = TimeSlot.current.vacant.has_length(duration).upcoming_with_buffer(2).for_dietitian(dietitian_id)
      end

      @cal_time_slots = @time_slots.to_a.flatten.uniq{|time_slot| time_slot.start_time}
    end
  end


  # GET /time_slots/1
  # GET /time_slots/1.json
  def show
  end

  # GET /time_slots/new
  def new
    @time_slot = TimeSlot.new
  end

  # GET /time_slots/1/edit
  def edit
  end

  # POST /time_slots
  # POST /time_slots.json
  def create

    num_create = params["number"].to_i
    ## create multiple of the same time_slot
    if num_create > 1
      new_params = time_slot_params
      for i in 1...num_create
      
       TimeSlot.new(new_params).save
      end
      @time_slot = TimeSlot.new(new_params)
    ## create single time_slot
    else
      @time_slot = TimeSlot.new(time_slot_params)
    end
    respond_to do |format|
      if @time_slot.save
        # prepare for updateding time_slots list for index in .js
        @time_slots = TimeSlot.order('start_time DESC').all
        format.html { redirect_to @time_slots, notice: 'Time slot was successfully created.' }
        format.json { render :show, status: :created, location: @time_slot }
        format.js
      else
        format.html { render :new }
        format.json { render json: @time_slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_slots/1
  # PATCH/PUT /time_slots/1.json
  def update
    respond_to do |format|
      if @time_slot.update(time_slot_params)
        format.html { redirect_to @time_slot, notice: 'Time slot was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_slot }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @time_slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_slots/1
  # DELETE /time_slots/1.json
  def destroy
    @time_slot_id = @time_slot.id
    @time_slot.destroy
    respond_to do |format|
      format.html { redirect_to time_slots_url, notice: 'Time slot was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  # get /time_slots/:id/create_from_existing
  def create_from_existing

    #create new object with attributes of existing record 
    @time_slot = TimeSlot.new(@time_slot.attributes.except("id")) 
    @time_slot.save

    if @time_slot.save
      @time_slots = TimeSlot.by_start_time
      respond_to do |format|
        format.js
      end
    end
  end

  # get /time_slots/create_from_availability
  # method not working?
  # method name coming in as parameter and before action set time slot being claled
  def create_from_availability
    open_availabilities = Availability.where(status: "Set")
    
    @new_time_slots = TimeSlot.create_from_availabilities(open_availabilities)
    
      respond_to do |format|
        format.js
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_slot
      
      @time_slot = TimeSlot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_slot_params
  
            ## switch month/day to day/month to match format for saving
        params[:time_slot][:start_time] = params[:time_slot][:start_time].gsub(%r{(.*)/(.*)/(.*)}, '\2/\1/\3') + " EST"
        params[:time_slot][:end_time] = params[:time_slot][:end_time].gsub(%r{(.*)/(.*)/(.*)}, '\2/\1/\3') + " EST"
        #       params[:time_slot][:start_time] = params[:time_slot][:start_time] + " EST"
        # params[:time_slot][:end_time] = params[:time_slot][:end_time] + " EST"

      params.require(:time_slot).permit(:title, :start_time, :end_time, :vacancy, :minutes, :status, :availability_id)
    end
end
