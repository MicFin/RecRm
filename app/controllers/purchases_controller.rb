class PurchasesController < ApplicationController
  # before_filter :load_purchasable
  include FamiliesHelper
  
  def index
    @user = current_user
    @appointment = Appointment.new(appointment_host_id: @user.id, status: "In Registration")
    @package = Package.last

    # Gather user's family data
    # from FamiliessHelper
    get_family!
    @family

    # @purchases = @purchasable.purchases
  end

  # GET purchasable_type/purchasable_id/purchases/new
  def new
     
    # if 30 in 
    # if 1 hr
    # if package
    @user = current_user
    @purchase = @purchasable.purchases.new
  end

  # POST /purchases
  # POST /purchases.json
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