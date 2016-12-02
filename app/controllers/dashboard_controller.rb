class DashboardController < ApplicationController
  include PatientGroupsHelper
  before_action :verify_admin, only: [:index]
  
  # GET /admin_dashboard
  def index
    # @online_dietitians = Dietitian.online
  end

  # GET /admin_dashboard
  def clients_onboarding
    
    # @clients_stage1 = User.client_accounts.at_stage(1).order_by_last_sign_in
    # @clients_stage2 = User.client_accounts.at_stage(2).order_by_last_sign_in
    # @clients_stage3 = User.client_accounts.at_stage(3).order_by_last_sign_in
    # @clients_stage4 = User.client_accounts.at_stage(4).order_by_last_sign_in
    # @clients_stage5 = User.client_accounts.at_stage(5).order_by_last_sign_in

    @leads = User.incomplete_onboarding.order_by_created_at

    @qol_referrals = User.qol_referrals.order_by_created_at

    @provider_referrals = User.provider_referrals.order_by_created_at

    @guest_user = GuestUser.all
  end

  def providers
    @providers = User.provider_accounts.order_by_created_at
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def verify_admin
      if current_dietitian.has_role? "Admin Dietitian" == false 
        render :no_access
      end
    end


end