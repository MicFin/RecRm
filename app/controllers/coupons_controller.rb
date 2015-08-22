class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin

  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = Coupon.all
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
  end

  # GET /coupons/new
  def new
    @coupon = Coupon.new
  end

  # GET /coupons/1/edit
  def edit
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = Coupon.new(coupon_params)

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to @coupon, notice: 'Coupon was successfully created.' }
        format.json { render :show, status: :created, location: @coupon }
      else
        format.html { render :new }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to @coupon, notice: 'Coupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @coupon }
      else
        format.html { render :edit }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /coupon/redeem_coupon
  def redeem_coupon

    coupon_code = params[:coupon_code]

    # Look for a coupon that meets the following conditions 
      # valid from is greater than or equal to today
      # valid until is less than or equal to today
      # coupon code matches user input and status is active
    coupon = Coupon.where("valid_from <= ? AND valid_until >= ?", Date.today, Date.today).where({
        code: coupon_code,
        status: "Active"
      }).last

    # Check if coupon redemptions are maxed out
    if coupon && (coupon.redemption_limit > coupon.redemptions_count)
      @variable = "yes coupon"
      create_coupon_redemption(coupon)
      binding.pry
    else
      @variable = "no coupon"
    end
    respond_to do |format|
      format.js 
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to coupons_url, notice: 'Coupon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def create_coupon_redemption(coupon)

    # Get users appointment currently in registration
    appointment = current_user.appointment_in_registration

    # Create CouponRedemption with status of Incomplete
    redemption = CouponRedemption.new(coupon_id: coupon.id, user_id: current_user.id, appointment_id: appointment.id, status: "Incomplete")


    if redemption.save 

      # Apply coupon to appointment
      appointment.redeem_coupon(coupon)

      # Redeem Coupon 
      # Should be AFTER payment completed
      coupon.redeemed

      # Change CouponRedemption status to Completed
      redemption.status = "Completed"
      redemption.save
    end
    


  end

    # Use callbacks to share common setup or constraints between actions.
    def set_coupon

      #coupons/redeem was calling the set_coupon method even though it is not included in the only[]
        @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:code, :description, :valid_from, :valid_until, :redemption_limit, :redemptions_count, :amount, :amount_type, :status)
    end

    # Only admin users can access coupon controller
    # should handle with pundit/rolify  correctly
    def authenticate_admin
      # if !current_dietitian || !current_dietitian.has_role? "Admin Dietitian"
      #   redirect_to welcome_home_path 
      # end
    end
end
