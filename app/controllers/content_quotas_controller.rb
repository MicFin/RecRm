class ContentQuotasController < ApplicationController
  before_action :set_content_quota, only: [:show, :edit, :update, :destroy]

  # GET /content_quota
  # GET /content_quota.json
  def index
    @dietitians = Dietitian.all
    @content_quotas = ContentQuota.all
    @today = Date.today
    @beginning_of_week = @today.at_beginning_of_week(:thursday)
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

  # PATCH /assign_content
  # PATCH /assign_content.json
  def assign_content
    # dietitians with quality review content quotas
    dietitians = Dietitian.includes(:content_quotas).where.not('content_quotas.quality_reviews' => nil, "content_quotas.quality_reviews" => 0).order(:created_at).references(:content_quota)
    # for each dietitian
    dietitians.each do |dietitian|
      # the dietitians quota amount
      quota = dietitian.content_quotas.first.quality_reviews - dietitian.incomplete_quality_reviews.count

      if quota > 0 
              # second tier reviews needing review
        second_tier = Recipe.all_need_second_tier_review
        if second_tier.count > 0
          sorted = second_tier.sort! { |a,b| a.created_at <=> b.created_at }
        # add to dietitian list of review
          sorted.each do |recipe| 
            ## shuold also not be any other previous reviewer
            ## get all previous reviewers in array and check
            ## must be a tier 2 reviewer
            if recipe.dietitian != dietitian 
              quality_review = recipe.quality_reviews.new(dietitian_id: dietitian.id, tier: 2)
              quota = quota - 1 
              quality_review.save
            end
            break if quota == 0
          end
        end
      end
      if quota > 0 
        # original reviews needing review
        original_reviews = Recipe.all_need_original_review
        if original_reviews.count > 0
          sorted = original_reviews.sort! { |a,b| a.created_at <=> b.created_at }
        # add to dietitian list of review
          sorted.each do |recipe| 
            if recipe.dietitian != dietitian
              ### should abe all teier 2 reviewers
              quality_review = recipe.quality_reviews.new(dietitian_id: dietitian.id, tier: 1)
              quota = quota - 1 
              quality_review.save
            end
            break if quota == 0
          end
        end
      end
      if quota > 0 
        # first tier reviews needing review
        first_tier = Recipe.all_need_first_tier_review
        if first_tier.count > 0
          sorted = first_tier.sort! { |a,b| a.created_at <=> b.created_at }
        # add to dietitian list of review
          sorted.each do |recipe| 
                  ## shuold also not be any other previous reviewer
            ## get all previous reviewers in array and check  
            if recipe.dietitian != dietitian
              quality_review = recipe.quality_reviews.new(dietitian_id: dietitian.id, tier: 1)
              quota = quota - 1  
              quality_review.save
            end
            break if quota == 0
          end
        end
        dietitian.save
      end
    end
    respond_to do |format|
        format.html { redirect_to content_quotas_path, notice: 'Content quotum was successfully created.' }
        format.json { render :show, status: :created, location: @content_quota }
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
