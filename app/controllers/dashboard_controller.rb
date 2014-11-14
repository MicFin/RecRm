class DashboardController < ApplicationController
  before_action :verify_admin, only: [:index, :recipe_status]
  before_filter :check_user_logged_in!, only: [:home]
  # GET /admin_dashboard
  def index
    @online_dietitians = Dietitian.online
  end

  
  def home
    
    @user = current_user
    @family = @user.head_of_families.last
    @appointment = @user.appointment_hosts.last
    @family_members = []
    if @appointment.patient_focus 
      appointment_focus = @appointment.patient_focus
      @family_members << appointment_focus
    end
    family_count = @family.users.count
    
    if family_count > 0

      if @user != appointment_focus
  
        @family_members << @user
        @family.users.each do |family_member| 
          if family_member != appointment_focus
      
            @family_members << family_member 
          end
        end
      else
        @family.users.each do |family_member|
            @family_members << family_member
        end
      end
    else
      @family_members << @user
    end

  end
  # GET /recipe_status
  def recipe_status
    @live_recipes = Recipe.where(live_recipe: true).order("created_at").reverse
    @recipes_with_unresolved_high_risk_conflicts = ReviewConflict.where(resolved: false).where(risk_level: 300).map { |review_conflict| review_conflict.quality_review.quality_reviewable}.uniq.compact
    @recipes_quality_review_stage_2_not_assigned = Recipe.all_need_second_tier_review
    @recipes_quality_review_stage_2_awaiting_resolutions = Recipe.second_tier_not_resolved
    @recipes_quality_review_stage_2_assigned = Recipe.all_in_second_tier_review
    @recipes_quality_review_stage_1_not_assigned = Recipe.all_need_first_tier_review
    @recipes_quality_review_stage_1_awaiting_resolutions = Recipe.first_tier_not_resolved
    @recipes_quality_review_stage_1_assigned = Recipe.all_in_first_tier_review
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def verify_admin
      if current_dietitian.has_role? "Admin Dietitian" == false 
        render :no_access
      end
    end

    def check_user_logged_in! 

      if current_user 
        # maybe do something else
      else
        # might want to do something later
      end
    end

end
