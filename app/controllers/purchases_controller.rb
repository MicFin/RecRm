class PurchasesController < ApplicationController
  before_filter :load_purchasable, only: [:new, :make_payment]
  before_filter :set_purchase, only: [:make_payment]

  include FamiliesHelper
  
  def index
    # @user = current_user
    # @appointment = Appointment.new(appointment_host_id: @user.id, status: "In Registration")
    # @package = Package.last

    # # Gather user's family data
    # # from FamiliessHelper
    # get_family!
    # @family

    # # @purchases = @purchasable.purchases
  end

  # GET purchasable_type/purchasable_id/purchases/new
  def new
    
    @user = current_user 
    
    if @purchasable.class == Appointment
      
      @time_slot = TimeSlot.find(params[:time_slot_id])

      @purchase = @purchasable.purchase || Purchase.new(user_id: @user.id, status: "Incomplete", purchasable_type: "Appointment", purchasable_id: @purchasable.id )
      
      @purchase.save
      
    else

      @purchase = Purchase.create(user_id: @user.id, status: "Incomplete", purchasable_type: "Package", purchasable_id: @purchasable.id )
      
      @purchase.save

    end
  
    # Only js response
    respond_to do |format|
      format.js
    end
  end


  # POST /purchases.json
  def create

    
    # @purchase = @purchasable.purchase.new(params[:purchase])
    # if @purchase.save
    #   redirect_to [@purchasable, :purchases], notice: "Purchase created."
    # else
    #   render :new
    # end
  end

  # GET /purchasable_type/:purchasable_id/purchase/:id/make_payment
  def make_payment
    
    
    token = purchase_params[:stripe_card_token]
    @purchase.stripe_card_token = token
    # @purchase.save

    # check if credit card should be saved to stripe account
    credit_card_usage = params[:credit_card_usage]
    
    # Update the purchase and make the stripe payment
    @purchase.update_with_payment(credit_card_usage, @purchasable)

    
    # If an appointment
    if @purchasable.class == Appointment

      # Get the time slot and save start and end time to appointment
      time_slot = TimeSlot.find(params[:time_slot_id])
      @purchasable.start_time = time_slot.start_time
      @purchasable.end_time = time_slot.end_time
      @purchasable.save

      
      # # Create pre appointment survey
      @pre_appt_survey = Survey.generate_for_appointment(@purchasable, current_user)
      
      # Set flash message
      flash_message = 'Appointment was successfully made.'

    # Else a package
    else

      # Create the user package 
      current_user.user_packages.create(package_id: @purchasable.id, purchase_date: Date.current)

      # Set flash message
      flash_message = 'Package was successfully purchased.'
    end

    
    # Only HTML response
    respond_to do |format|
      format.html { redirect_to welcome_home_path, notice: flash_message }
      # format.js
    end

  end

private

  def load_purchasable

    # resource, id = request.path.split('/')[1,2]
    # @purchasable = resource.singularize.classify.constantize.find(id)
    klass = [Appointment, Package ].detect { |c| params["#{c.name.underscore}_id"]}
    @purchasable = klass.find(params["#{klass.name.underscore}_id"])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def purchase_params
    params.require(:purchase).permit(:user_id, :status, :stripe_card_token, :purchasable_id, :purchasable_type)
  end

  def set_purchase
    
    @purchase = Purchase.find(params[:id])
  end
end

    # t.integer  "user_id"            // User who made purchase
    # t.integer  "purchasable_id"     // Appointment or Package ID
    # t.string   "purchasable_type"   // Appointment or Package
    # t.datetime "created_at"         // First created
    # t.datetime "updated_at"         // Last updated
    # t.string   "stripe_card_token"  // Stripe card token
    # t.integer  "invoice_price"      // Total price of invoice
    # t.integer  "invoice_cost"       // Total cost of invoice
    # t.string   "status"             // Status: Incomplete or Complete
    # t.datetime "completed_at"       // Date and time purchase completed