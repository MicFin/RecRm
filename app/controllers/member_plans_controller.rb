class MemberPlansController < ApplicationController
  before_action :set_member_plan, only: [:show, :edit, :update, :destroy]

  # GET /member_plans
  # GET /member_plans.json
  def index
    @member_plans = MemberPlan.all
    @subscribers = UserRole.where(resource_type: "MemberPlan")
    @members = UserRole.where(resource_type: "Plan")
    binding.pry
  end

  # GET /member_plans/1
  # GET /member_plans/1.json
  def show
  end

  # GET /member_plans/new
  def new
    @member_plan = MemberPlan.new
  end

  # GET /member_plans/1/edit
  def edit
  end

  # POST /member_plans
  # POST /member_plans.json
  def create
    @member_plan = member_plan.new(member_plan_params)

    respond_to do |format|
      if @member_plan.save
        format.html { redirect_to @member_plan, notice: 'member_plan was successfully created.' }
        format.json { render :show, status: :created, location: @member_plan }
      else
        format.html { render :new }
        format.json { render json: @member_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /member_plans/1
  # PATCH/PUT /member_plans/1.json
  def update
    respond_to do |format|
      if @member_plan.update(member_plan_params)
        format.html { redirect_to @member_plan, notice: 'member_plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @member_plan }
      else
        format.html { render :edit }
        format.json { render json: @member_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /member_plans/1
  # DELETE /member_plans/1.json
  def destroy
    @member_plan.destroy
    respond_to do |format|
      format.html { redirect_to member_plans_url, notice: 'member_plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member_plan
      @member_plan = MemberPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_plan_params
      params.require(:member_plan).permit(:name, :stripe_id, :amount, :currency, :interval, :live_mode, :interval_count, :trial_period_days, :statement_description, :plan_id)
    end
end

