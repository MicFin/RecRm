class MarketingItemsController < ApplicationController
  before_filter :load_marketing_itemable
  before_filter :set_marketing_item, only: [:update, :edit]
  before_filter :set_characteristic_display, only: [:new]

  def index
    @marketing_items = @marketing_itemable.marketing_items
    @new_tweet = @marketing_itemable.marketing_items.new(category: "tweet", order: 1, dietitian_id: current_dietitian.id)
    @new_introduction = @marketing_itemable.marketing_items.new(category: "introduction", order: 1, dietitian_id: current_dietitian.id)
    @new_headline = @marketing_itemable.marketing_items.new(category: "headline", order: 1, dietitian_id: current_dietitian.id)
  end

  def new_titles
    # need logic to create as many titles as there are patient groups
    @new_title = @marketing_itemable.marketing_items.new(category: "title", order: 1, dietitian_id: current_dietitian.id)
  end

  def create_titles
    # need logic to create as many titles as there are patient groups
    @marketing_item = @marketing_itemable.marketing_items.new(marketing_item_params)
    respond_to do |format|
      if @marketing_item.save
        format.html { redirect_to [@marketing_itemable, :marketing_items], notice: "Marketing Item created."}
        format.json { render :show, status: :created, location: @marketing_item} 
        # want it to put on right and go to new descriptions
        format.js
      else
        format.html { render :new }
        format.json { render json: @marketing_itemable.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def new_descriptions
    # need logic to create as many descriptions as there are patient groups
    @new_title = @marketing_itemable.marketing_items.new(category: "description", order: 1, dietitian_id: current_dietitian.id)
  end
  
  def create_descriptions
    # need logic to create as many descriptions as there are patient groups
    @marketing_item = @marketing_itemable.marketing_items.new(marketing_item_params)
    respond_to do |format|
      if @marketing_item.save
        format.html { redirect_to [@marketing_itemable, :marketing_items], notice: "Marketing Item created."}
        format.json { render :show, status: :created, location: @marketing_item} 
        # want it to put on right and go to recipes_review page
        format.js
      else
        format.html { render :new }
        format.json { render json: @marketing_itemable.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def new
    @new_tweet = @marketing_itemable.marketing_items.new(category: "tweet", order: 1, dietitian_id: current_dietitian.id)
    @new_introduction = @marketing_itemable.marketing_items.new(category: "introduction", order: 1, dietitian_id: current_dietitian.id)
    @new_headline = @marketing_itemable.marketing_items.new(category: "headline", order: 1, dietitian_id: current_dietitian.id)
  end

  def edit
  end

  def create
    @marketing_item = @marketing_itemable.marketing_items.new(marketing_item_params)
    respond_to do |format|
      if @marketing_item.save
        format.html { redirect_to [@marketing_itemable, :marketing_items], notice: "Marketing Item created."}
        format.json { render :show, status: :created, location: @marketing_item} 
        format.js
      else
        format.html { render :new }
        format.json { render json: @marketing_itemable.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /articles/:id/marketing_item/:id
  # PATCH/PUT /articles/:id/marketing_item/:id.json
  def update
    respond_to do |format|
      if @marketing_item.update(marketing_item_params)
        format.html { redirect_to @marketing_item, notice: 'Marketing Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @marketing_item }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @marketing_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST articles/:id/marketing_items/index
  # routing is off ^^
  def show
    # @marketing_items = @marketing_itemable.marketing_items
    # @new_tweet = @marketing_itemable.marketing_items.new(category: "tweet", order: 1, dietitian_id: current_dietitian.id)
    # @new_introduction = @marketing_itemable.marketing_items.new(category: "introduction", order: 1, dietitian_id: current_dietitian.id)
    # @new_headline = @marketing_itemable.marketing_items.new(category: "headline", order: 1, dietitian_id: current_dietitian.id)
  end

  private

  # identifies whether the resource is an article or recipe before assigning instance variable @marketing_itemable as a recipe or article with the passed id returns the recipe or article object as marketing_itemable
  def load_marketing_itemable
    klass = [Article, Recipe].detect { |c| params["#{c.name.underscore}_id"]}
    @marketing_itemable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def marketing_item_params
    params.require(:marketing_item).permit(:content, :dietitian_id, :category, :order)
  end

  def set_marketing_item
    @marketing_item = MarketingItem.find(params[:id])
  end

  ### make as global helper method because also used in recipes_controller
  def set_characteristic_display
    @age_groups = @marketing_itemable.characteristics.where(category: "Age Group")
    @scenarios = @marketing_itemable.characteristics.where(category: "Scenario")
    @holidays = @marketing_itemable.characteristics.where(category: "Holiday")
    @cultures = @marketing_itemable.characteristics.where(category: "Culture")
    @patient_groups = @marketing_itemable.patient_groups
  end


end