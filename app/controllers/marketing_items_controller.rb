class MarketingItemsController < ApplicationController
  include CharacteristicsHelper
  before_filter :load_marketing_itemable
  before_filter :set_marketing_item, only: [:update, :edit]

  def new
    @marketing_items = {}
    if @marketing_itemable.creation_stage < 6
      @marketing_itemable.creation_stage = 6
      @marketing_itemable.save
    end
    if @marketing_itemable.patient_groups.count > 0
      @marketing_itemable.patient_groups.each do |patient_group|
        @marketing_items[patient_group] = {title: @marketing_itemable.marketing_items.new(category: "title", dietitian_id: current_dietitian.id), description: @marketing_itemable.marketing_items.new(category: "description", dietitian_id: current_dietitian.id)} 
      end
    end
    @marketing_items["General"] = {title: @marketing_itemable.marketing_items.new(category: "title", dietitian_id: current_dietitian.id), description: @marketing_itemable.marketing_items.new(category: "description", dietitian_id: current_dietitian.id)} 
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
    @marketing_item 
    @marketing_itemable
    if @marketing_item.patient_group
      @patient_group_id = @marketing_item.patient_group_id
    else 
      @patient_group_id = 0
    end
    @item_category = @marketing_item.category
  end

  def create
    @marketing_item = @marketing_itemable.marketing_items.new(marketing_item_params)
    respond_to do |format|
      if @marketing_item.save
        if @marketing_item.patient_group
          @patient_group_id = @marketing_item.patient_group_id
        else 
          @patient_group_id = 0
        end
        format.html { redirect_to [@marketing_itemable, :marketing_items], notice: "Marketing Item created."}
        format.json { render :show, status: :created, location: @marketing_item} 
        # for preview
        @marketing_item = @marketing_item
        @item_category = params[:marketing_item][:category]
        @recipe_id = params[:recipe_id]
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
    if @marketing_item.patient_group
      @patient_group_id = @marketing_item.patient_group_id
    else 
      @patient_group_id = 0
    end
    @item_category = params[:marketing_item][:category]
    @recipe_id = params[:recipe_id]
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

  # POST articles/:id/marketing_items
  def index
    @marketing_items_by_group = @marketing_itemable.marketing_items_by_group
    @recipe_id = @marketing_itemable.id
  end

  private

  # identifies whether the resource is an article or recipe before assigning instance variable @marketing_itemable as a recipe or article with the passed id returns the recipe or article object as marketing_itemable
  def load_marketing_itemable
    klass = [Article, Recipe].detect { |c| params["#{c.name.underscore}_id"]}
    @marketing_itemable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def marketing_item_params
    params.require(:marketing_item).permit(:content, :dietitian_id, :category, :order, :patient_group_id)
  end

  def set_marketing_item
    @marketing_item = MarketingItem.find(params[:id])
  end


end