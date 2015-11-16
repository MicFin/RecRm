class GrowthEntriesController < ApplicationController
  before_action :set_growth_entry, only: [:show, :edit, :update, :destroy]
  before_action :set_growth_chart, only: [:new, :edit, :update, :create, :destroy]
  # GET /growth_chart/:growth_chart_id/growth_entries
  # GET /growth_chart/:growth_chart_id/growth_entries.json
  def index
    @growth_entries = GrowthEntry.all
  end

  # GET /growth_chart/:growth_chart_id/growth_entries/1
  # GET /growth_chart/:growth_chart_id/growth_entries/1.json
  def show
  end

  # GET /growth_chart/:growth_chart_id/growth_entries/new
  def new
    @growth_entry = GrowthEntry.new
  end

  # GET /growth_chart/:growth_chart_id/growth_entries/1/edit
  def edit
  end

  # POST /growth_chart/:growth_chart_id/growth_entries
  # POST /growth_chart/:growth_chart_id/growth_entries.json
  def create
    
    clean_height_and_weight_input
    
    @growth_entry = GrowthEntry.new(growth_entry_params)

    respond_to do |format|
      if @growth_entry.save
        format.html { redirect_to @growth_chart, notice: 'Growth entry was successfully created.' }
        format.json { render :show, status: :created, location: @growth_entry }
        format.js
      else
        format.html { render :new }
        format.json { render json: @growth_entry.errors, status: :unprocessable_entity }
        format.js 
      end
    end
  end

  # PATCH/PUT /growth_chart/:growth_chart_id/growth_entries/1
  # PATCH/PUT /growth_chart/:growth_chart_id/growth_entries/1.json
  def update

    clean_height_and_weight_input

    respond_to do |format|
      if @growth_entry.update_attributes(growth_entry_params)
        format.html { redirect_to @growth_chart, notice: 'Growth entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @growth_entry }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @growth_entry.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end


  # DELETE /growth_chart/:growth_chart_id/growth_entries/1
  # DELETE /growth_chart/:growth_chart_id/growth_entries/1.json
  def destroy
    @growth_entry_id = @growth_entry.id

    respond_to do |format|
      if @growth_entry.destroy
        format.html { redirect_to @growth_chart, notice: 'Growth entry was successfully destroyed.' }
        format.json { head :no_content }
        format.js
      else
        flash.now[:error] = "Can not delete growth entry that has been reviewd by a dietitian."
        format.html { render @growth_chart }    
        format.js    
      end    
    

   
    end
  end

  private

    # Height and weight must be changed from ft+in and lb+oz to just inches and ounces before being saved
    def clean_height_and_weight_input

      # Check if  input was submitted
      if params["growth_entry"]

        # Check if  height was submitted
        if params["growth_entry"]["height"]

          # Check if user height feet was submitted
          if (params["growth_entry"]["height"]["feet"].to_i >= 1)

            # Convert feet to inches
            params["growth_entry"]["height"]["feet"] = params["growth_entry"]["height"]["feet"].to_i * 12

            # Add to inches to get a total in inches
            params["growth_entry"]["height_in_inches"] = params["growth_entry"]["height"]["feet"].to_i + params["growth_entry"]["height"]["inches"].to_i

          # If no feet submitted then update param
          else 
              params["growth_entry"]["height_in_inches"] = params["growth_entry"]["height"]["inches"].to_i
          end

          # Delete height param since it will be saved as height_in_inches
          params["growth_entry"].delete "height"
        end

        # Check if  weight was submitted
        if params["growth_entry"]["weight"]

          # Check if user weight pounds was submitted
          if (params["growth_entry"]["weight"]["pounds"].to_i >= 1)

            # Convert pounds to ounces
            params["growth_entry"]["weight"]["pounds"] = params["growth_entry"]["weight"]["pounds"].to_i * 16
            
            # Add to ounces to get a total in ounces
            params["growth_entry"]["weight_in_ounces"] = params["growth_entry"]["weight"]["pounds"].to_i + params["growth_entry"]["weight"]["ounces"].to_i

          # If no feet submitted then update param
          else 
              params["growth_entry"]["weight_in_ounces"] = params["growth_entry"]["weight"]["ounces"].to_i
          end

          # Delete weight param since it will be saved as weight_in_ounces
          params["growth_entry"].delete "weight"
        end
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_growth_entry
      @growth_entry = GrowthEntry.find(params[:id])
    end

    def set_growth_chart
      @growth_chart = GrowthChart.find(params[:growth_chart_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def growth_entry_params
      params.require(:growth_entry).permit(:growth_chart_id, :measured_at, :height_in_inches, :weight_in_ounces, :age, :user_id, :fluids_requirement, :energy_requirement, :protein_requirement, :bmi_percentile, :bmi_z_score, :height_percentile, :height_z_score, :weight_percentile, :weight_z_score, :dietitian_note, :client_note)
    end
end
