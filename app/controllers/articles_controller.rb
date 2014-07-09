class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_characteristic_forms, only: [:new, :edit]
  before_action :set_characteristic_display, only: [:show]
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
    @dietitian_id = current_dietitian.id
    @allergies = PatientGroup.allergies
    @diseases = PatientGroup.diseases
    @intolerances = PatientGroup.intolerances
  end

  # GET /articles/add_marketing
  def add_marketing
    @article = Article.find(params[:id])
    @marketing_itemable = @article
    @marketing_items = @marketing_itemable.marketing_items
    @marketing_item = MarketingItem.new
  end

  # GET /articles/1/edit
  def edit
    @allergies = PatientGroup.allergies
    @diseases = PatientGroup.diseases
    @intolerances = PatientGroup.intolerances
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to new_article_marketing_item_path(article_id: @article.id), notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_characteristic_forms
    # set instance variables for form fields
      @age_groups = Characteristic.where(category: "Age Group")
      @scenarios = Characteristic.where(category: "Scenario")
      @holidays = Characteristic.where(category: "Holiday")
      @cultures = Characteristic.where(category: "Culture")
      @appeals = Characteristic.where(category: "appeal")
      @writing_categories = Characteristic.where(category: "writing category")
      @call_to_actions = Characteristic.where(category: "call to action")
      @diagnosis_stages = Characteristic.where(category: "diagnosis stage")
    end
    ### make as global helper method because also used in recipes_controller
    def set_characteristic_display
      @age_groups = @article.characteristics.where(category: "Age Group")
      @scenarios = @article.characteristics.where(category: "Scenario")
      @holidays = @article.characteristics.where(category: "Holiday")
      @cultures = @article.characteristics.where(category: "Culture")
      @appeals = @article.characteristics.where(category: "appeal")
      @writing_categories = @article.characteristics.where(category: "writing category")
      @call_to_actions = @article.characteristics.where(category: "call to action")
      @diagnosis_stages = @article.characteristics.where(category: "diagnosis stage")

      @allergies = @article.allergies
      @diseases = @article.diseases
      @intolerances = @article.intolerances
    end


    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :dietitian_id, :characteristic_ids => [], :patient_group_ids => [])
    end
end
