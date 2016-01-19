class DashboardController < ApplicationController
  include PatientGroupsHelper
  before_action :verify_admin, only: [:index]
  
  # GET /admin_dashboard
  def index
    @online_dietitians = Dietitian.online
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def verify_admin
      if current_dietitian.has_role? "Admin Dietitian" == false 
        render :no_access
      end
    end


end