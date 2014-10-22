class ContentQuotasController < ApplicationController
  before_action :set_content_quota, only: [:show, :edit, :update, :destroy]

  # GET /content_quota
  # GET /content_quota.json
  def index
    @dietitians = Dietitian.all
    @content_quotas = ContentQuota.all
  end

  # GET /content_quota/1
  # GET /content_quota/1.json
  def show
  end

  # GET /content_quota/new
  def new
    @dietitians = Dietitian.all
    if params[:dietitian_id]
      @dietitian = Dietitian.find(params[:dietitian_id])
    end
    @content_quota = ContentQuota.new
  end

  # GET /content_quota/1/edit
  def edit
    @dietitians = Dietitian.all
    @dietitian = @content_quota.dietitian
  end

  # POST /content_quota
  # POST /content_quota.json
  def create
    @content_quota = ContentQuota.new(content_quota_params)

    respond_to do |format|
      if @content_quota.save
        format.html { redirect_to content_quotas_path, notice: 'Content quotum was successfully created.' }
        format.json { render :show, status: :created, location: @content_quota }
      else
        format.html { render :new }
        format.json { render json: @content_quota.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /content_quota/1
  # PATCH/PUT /content_quota/1.json
  def update
    respond_to do |format|
      if @content_quota.update(content_quota_params)
        format.html { redirect_to content_quotas_path, notice: 'Content quota was successfully updated.' }
        format.json { render :show, status: :ok, location: @content_quota }
      else
        format.html { render :edit }
        format.json { render json: @content_quota.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /content_quota/1
  # DELETE /content_quota/1.json
  def destroy
    @content_quota.destroy
    respond_to do |format|
      format.html { redirect_to content_quota_url, notice: 'Content quota was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_quota
      @content_quota = ContentQuota.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_quota_params
      params[:content_quota]
      params.require(:content_quota).permit(:dietitian_id, :recipes, :quality_reviews, :review_conflicts)
    end
end
