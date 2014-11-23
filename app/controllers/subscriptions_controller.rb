class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.all
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    binding.pry
    @prem_subs = Subscription.new(member_plan_id: 1)
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    cards = customer.cards.all(:limit => 3)
    binding.pry
    if cards[:data].count > 0
      @credit_card = { last4: cards[:data].last[:last4], brand: cards[:data].last[:brand] } 
    else
      @credit_card = nil 
    end
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    binding.pry
    # retrieve stripe customer
    @user = current_user
    customer = Stripe::Customer.retrieve(@user.stripe_id)

    #### nothing here if no CC is on file or wants to use another CC, all based on saved CC

    # charge for new subscription
    begin 
      customer.subscriptions.create(:plan => "3_month")
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_subscription_path
    end
    # create local subscrition until webhooks initiated
    @subscription = Subscription.new(subscription_params)
    ## assigns first subscipriton as subscription ID...not sure this is correct but .last wouldn't work, might need webhooks here too
    new_subscription_stripe_id = customer.subscriptions.all(:limit => 3).first.id
    # connect local subscription to stripe with ID 
    @subscription.stripe_id = new_subscription_stripe_id
    respond_to do |format|
      if @subscription.save
        # is subscription is saved then create roles for user 
        binding.pry
        member_plan = @subscription.member_plan 
        # subscriber of member_plan
        @user.add_role "Subscriber", member_plan
        plan = member_plan.plan 
        # member of plan
        @user.add_role "Member", plan
        @user.save
        format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:member_plan_id, :user_id, :start_date, :end_date, :type, :trial_end, :trial_start, :ended_at, :current_period_start, :current_period_end, :cancelled_at, :status, :quantity, :stripe_id)
    end
end
