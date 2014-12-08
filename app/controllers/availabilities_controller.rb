class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [:show, :edit, :update, :destroy]

  # GET /availabilities
  # GET /availabilities.json
  def index
    ### call with JS to create calendars
    #### admin_dietitian view all availabilities by
    # if current_dietitian.has_role? "Admin Dietitian"
    #   @availabilities = Availability.all
    # else
      @availabilities = current_dietitian.availabilities
    # end
    ### regular dietitian view only their availabilities
    ### current_dietitian.availabilities
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
    params[:availabilities].each do |availability_hash|
      new_avail = Availability.new(availability_hash[1])
      new_avail.dietitian = current_dietitian
      new_avail.status = "Set"
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

  # DELETE /availabilities/1
  # DELETE /availabilities/1.json
  def destroy
    @availability.destroy
    respond_to do |format|
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
