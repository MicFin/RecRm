class HistoryController < ApplicationController
  before_filter :verify_admin

  def users
    @versions = PaperTrail::Version.order('created_at DESC')
  end

  def verify_admin
    if !current_dietitian.has_role? "Admin Dietitian" 
      redirect_to dietitian_unauthenticated_root_path
    end
  end
end
