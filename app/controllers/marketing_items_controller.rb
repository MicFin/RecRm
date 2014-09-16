class MarketingItemsController < ApplicationController
  include CharacteristicsHelper
  before_filter :load_marketing_itemable
  before_filter :set_marketing_item, only: [:update, :edit]

  # def index
  #   @marketing_items = @marketing_itemable.marketing_items
  #   @new_tweet = @marketing_itemable.marketing_items.new(category: "tweet", order: 1, dietitian_id: current_dietitian.id)
  #   @new_introduction = @marketing_itemable.marketing_items.new(category: "introduction", order: 1, dietitian_id: current_dietitian.id)
  #   @new_headline = @marketing_itemable.marketing_items.new(category: "headline", order: 1, dietitian_id: current_dietitian.id)
  # end

  # def new_titles
  #   # need logic to create as many titles as there are patient groups
  #   @new_title = @marketing_itemable.marketing_items.new(category: "title", order: 1, dietitian_id: current_dietitian.id)
  # end

  # def create_titles
  #   # need logic to create as many titles as there are patient groups
    # @marketing_item = @marketing_itemable.marketing_items.new(marketing_item_params)
  #   respond_to do |format|
  #     if @marketing_item.save
  #       format.html { redirect_to [@marketing_itemable, :marketing_items], notice: "Marketing Item created."}
  #       format.json { render :show, status: :created, location: @marketing_item} 
  #       # want it to put on right and go to new descriptions
  #       format.js
  #     else
  #       format.html { render :new }
  #       format.json { render json: @marketing_itemable.errors, status: :unprocessable_entity }
  #       format.js
  #     end
  #   end
  # end

  # def new_descriptions
  #   # need logic to create as many descriptions as there are patient groups
  #   @new_title = @marketing_itemable.marketing_items.new(category: "description", order: 1, dietitian_id: current_dietitian.id)
  # end
  
  # def create_descriptions
  #   # need logic to create as many descriptions as there are patient groups
  #   @marketing_item = @marketing_itemable.marketing_items.new(marketing_item_params)
  #   respond_to do |format|
  #     if @marketing_item.save
  #       format.html { redirect_to [@marketing_itemable, :marketing_items], notice: "Marketing Item created."}
  #       format.json { render :show, status: :created, location: @marketing_item} 
  #       # want it to put on right and go to recipes_review page
  #       format.js
  #     else
  #       format.html { render :new }
  #       format.json { render json: @marketing_itemable.errors, status: :unprocessable_entity }
  #       format.js
  #     end
  #   end
  # end

  def new
    @marketing_items = {}
    if @marketing_itemable.patient_groups.count > 0
      @marketing_itemable.patient_groups.each do |patient_group|
        @marketing_items[patient_group] = {title: @marketing_itemable.marketing_items.new(category: "title", dietitian_id: current_dietitian.id), description: @marketing_itemable.marketing_items.new(category: "description", dietitian_id: current_dietitian.id)} 
      end
    else
      @marketing_items["General Health"] = {title: @marketing_itemable.marketing_items.new(category: "title", dietitian_id: current_dietitian.id), description: @marketing_itemable.marketing_items.new(category: "description", dietitian_id: current_dietitian.id)} 
    end
    if @marketing_itemable.creation_stage < 6
      @marketing_itemable.creation_stage = 6
      @marketing_itemable.save
    end
    # forced js response
    respond_to do |format|
      @marketing_items = @marketing_items
      @marketing_itemable = @marketing_itemable
      # for preview
      @patient_groups = @marketing_itemable.patient_groups
      # for breadcrumb must be sent as recipe and recipe_id
      @recipe_id = @marketing_itemable.id
      @recipe = @marketing_itemable
      format.js {render "new" and return}
      format.html { render "new_items_page"}
    end
  end

  def edit
  end

  def create
    @marketing_item = @marketing_itemable.marketing_items.new(marketing_item_params)
    respond_to do |format|
      if @marketing_item.save
        binding.pry
        format.html { redirect_to [@marketing_itemable, :marketing_items], notice: "Marketing Item created."}
        format.json { render :show, status: :created, location: @marketing_item} 
        # for preview
        @marketing_item = @marketing_item
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
    binding.pry
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


end