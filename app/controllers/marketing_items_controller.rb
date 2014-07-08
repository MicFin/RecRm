class MarketingItemsController < ApplicationController
  before_filter :load_marketing_itemable

  def index
    @marketing_items = @marketing_itemable.marketing_items
  end

  def new
    @marketing_item = @marketing_itemable.marketing_items.new
  end
    
  def create
    @marketing_item = @marketing_itemable.marketing_items.new(params[:marketing_item])
    if @marketing_item.save
      redirect_to [@marketing_itemable, :marketing_items], notice: "Marketing Item created."
    else
      render :new
    end
  end


  private

  # identifies whether the resource is an article or recipe before assigning instance variable @marketing_itemable to the recipe or article with the current id
  def load_marketing_itemable
    klass = [Article, Recipe].detect { |c| params["#{c.name.underscore}_id"]}
    @marketing_itemable = klass.find(params["#{klass.name.underscore}_id"])
  end
end