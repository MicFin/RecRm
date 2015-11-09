class GrowthChartsController < ApplicationController
  before_action :set_growth_chart, only: [:show, :edit, :update, :destroy]

  # GET /growth_charts
  # GET /growth_charts.json
  def index
    @growth_charts = GrowthChart.all
  end

  # GET /growth_charts/1
  # GET /growth_charts/1.json
  def show
    @growth_entry = GrowthEntry.new
  end

  # GET /growth_charts/new
  def new
    @growth_chart = GrowthChart.new
  end

  # GET /growth_charts/1/edit
  def edit
  end

  # POST /growth_charts
  # POST /growth_charts.json
  def create
    @growth_chart = GrowthChart.new(growth_chart_params)

    respond_to do |format|
      if @growth_chart.save
        format.html { redirect_to @growth_chart, notice: 'Growth chart was successfully created.' }
        format.json { render :show, status: :created, location: @growth_chart }
      else
        format.html { render :new }
        format.json { render json: @growth_chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /growth_charts/1
  # PATCH/PUT /growth_charts/1.json
  def update
    respond_to do |format|
      if @growth_chart.update(growth_chart_params)
        format.html { redirect_to @growth_chart, notice: 'Growth chart was successfully updated.' }
        format.json { render :show, status: :ok, location: @growth_chart }
      else
        format.html { render :edit }
        format.json { render json: @growth_chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /growth_charts/1
  # DELETE /growth_charts/1.json
  def destroy
    @growth_chart.destroy
    respond_to do |format|
      format.html { redirect_to growth_charts_url, notice: 'Growth chart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_growth_chart
      @growth_chart = GrowthChart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def growth_chart_params
      params.require(:growth_chart).permit(:user_id)
    end
end
