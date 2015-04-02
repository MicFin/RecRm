class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [:show, :edit, :update, :destroy]

  # GET /availabilities
  # GET /availabilities.json
  def index
    ### call with JS to create calendars
    #### admin_dietitian view all availabilities by
    if ( (current_dietitian.has_role? "Admin Dietitian") && (params[:dietitian_id]) ) 
      dietitian = Dietitian.find(params[:dietitian_id])
      @availabilities = dietitian.availabilities
    else
    ### regular dietitian view only their availabilities
      @availabilities = current_dietitian.availabilities
    end

  end

  # GET /availabilities/1
  # GET /availabilities/1.json
  def show
  end

  # GET /availabilities/new
  def new
    @availability = Availability.new
  end

  # GET /availabilities/1/edit
  def edit
  end

  # POST /availabilities
  # POST /availabilities.json
  def create
    @availability = Availability.new(availability_params)

    respond_to do |format|
      if @availability.save
        format.html { redirect_to @availability, notice: 'Availability was successfully created.' }
        format.json { render :show, status: :created, location: @availability }
      else
        format.html { render :new }
        format.json { render json: @availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /availabilities/set_schedule
  # POST /availabilities/set_schedule.json
  def set_schedule
   binding.pry
    params[:availabilities].each do |availability_hash|
      new_avail = Availability.new(availability_hash[1])
      new_avail.dietitian = current_dietitian
      new_avail.save
      binding.pry
      # if the availability is within 1 week from today then create time slots for it which will mark it live
      if Date.parse(availability_hash[1]["start_time"]) < Date.today + 7
        # new_avail.status = "Live" 
        # create time slots  
        TimeSlot.create_from_availability(new_avail)
      else
        new_avail.status = "Set"
      end
      new_avail.save
    end
    
    respond_to do |format|
        format.html { redirect_to availabilities_path, notice: 'Schedule was successfully updated.' }
        format.js
    end
  end

  # PATCH/PUT /availabilities/1
  # PATCH/PUT /availabilities/1.json
  def update
    
    respond_to do |format|
      if @availability.update(availability_params)
        format.html { redirect_to @availability, notice: 'Availability was successfully updated.' }
        format.json { render :show, status: :ok, location: @availability }
      else
        format.html { render :edit }
        format.json { render json: @availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /availabilities/update_schedule
  # PATCH/PUT /availabilities/update_schedule.json
  def update_schedule
    
    params[:availabilities].each do |availability_hash|
      updated_avail = Availability.find(availability_hash[1]["id"])
      availability_hash[1].delete "id"
      
      updated_avail.update(availability_hash[1])
      
    end
    
    respond_to do |format|
        format.js
        format.html { redirect_to availabilities_path, notice: 'Schedule was successfully updated.' }
    end
  end

  # DELETE /availabilities/1
  # DELETE /availabilities/1.json
  def destroy
    
    @availability.destroy
    
    respond_to do |format|
      format.js
      format.html { redirect_to availabilities_url, notice: 'Availability was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_availability
      @availability = Availability.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def availability_params
      
      params.require(:availability).permit(:start_time, :end_time, :buffered_start_time, :buffered_end_time, :status)
    end
end
