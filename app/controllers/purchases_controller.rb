class PurchaseController < ApplicationController
  before_filter :load_purchasable
  
  def index
    @purchases = @purchasable.purchases
  end

  def new
    @purchase = @purchasable.purchases.new
  end
    
  def create
    @purchase = @purchasable.purchases.new(params[:purchase])
    if @purchase.save
      redirect_to [@purchasable, :purchases], notice: "Purchase created."
    else
      render :new
    end
  end
private

  def load_purchasable
    # resource, id = request.path.split('/')[1,2]
    # @purchasable = resource.singularize.classify.constantize.find(id)
  klass = [Appointment, Package ].detect { |c| params["#{c.name.underscore}_id"]}
  @purchasable = klass.find(params["#{klass.name.underscore}_id"])
  end
end