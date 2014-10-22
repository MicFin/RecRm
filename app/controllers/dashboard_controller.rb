class DashboardController < ApplicationController
  before_action :verify_admin

  # GET /admin_dashboard
  def index

  end

  # GET /recipe_status
  def recipe_status
    @live_recipes = Recipe.where(live_recipe: true).order("created_at").reverse
    @recipes_with_unresolved_high_risk_conflicts = ReviewConflict.where(resolved: false).where(risk_level: 300).map { |review_conflict| review_conflict.quality_review.quality_reviewable}.uniq
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

end
