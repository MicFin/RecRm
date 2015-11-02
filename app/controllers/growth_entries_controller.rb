class GrowthEntriesController < ApplicationController
  before_action :set_growth_entry, only: [:show, :edit, :update, :destroy]

  # GET /growth_entries
  # GET /growth_entries.json
  def index
    @growth_entries = GrowthEntry.all
  end

  # GET /growth_entries/1
  # GET /growth_entries/1.json
  def show
  end

  # GET /growth_entries/new
  def new
    @growth_entry = GrowthEntry.new
  end

  # GET /growth_entries/1/edit
  def edit
  end

  # POST /growth_entries
  # POST /growth_entries.json
  def create
    @growth_entry = GrowthEntry.new(growth_entry_params)

    respond_to do |format|
      if @growth_entry.save
        format.html { redirect_to @growth_entry, notice: 'Growth entry was successfully created.' }
        format.json { render :show, status: :created, location: @growth_entry }
      else
        format.html { render :new }
        format.json { render json: @growth_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /growth_entries/1
  # PATCH/PUT /growth_entries/1.json
  def update
    respond_to do |format|
      if @growth_entry.update(growth_entry_params)
        format.html { redirect_to @growth_entry, notice: 'Growth entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @growth_entry }
      else
        format.html { render :edit }
        format.json { render json: @growth_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /growth_entries/1
  # DELETE /growth_entries/1.json
  def destroy
    @growth_entry.destroy
    respond_to do |format|
      format.html { redirect_to growth_entries_url, notice: 'Growth entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_growth_entry
      @growth_entry = GrowthEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def growth_entry_params
      params.require(:growth_entry).permit(:growth_chart_id, :entry_measured_at, :height_in_inches, :weight_in_ounces, :age)
    end
end
