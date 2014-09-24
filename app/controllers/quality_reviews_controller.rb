class QualityReviewsController < ApplicationController
  before_filter :load_quality_reviewable
  before_filter :set_quality_review, only: [:update, :edit]

  def new
    @recipe_id = params[:recipe_id]
    @recipe = Recipe.find(@recipe_id)
    @quality_review = QualityReview.new(dietitian_id: current_dietitian.id, quality_reviewable_id: @recipe.id, quality_reviewable_type: "Recipe", date_due_by: DateTime.now+14)
    @quality_review.save 
    ## create or use helpers for these
    @ingredients = @recipe.ingredients_recipes
    @steps = @recipe.recipe_steps
    @health_groups = @recipe.patient_groups
    @categories = @recipe.characteristics
    @marketing_items_by_group = @recipe.marketing_items_by_group
    @ingredients_tagged = @recipe.ingredients_tagged
    @ingredients_not_tagged = @recipe.ingredients_not_tagged
    # create methods on recipe model and helpers to get these
    # then put them in review_conflict_controller and have qulaity_review make ajax calls for forms when clicked
    # for now this should do until further code can be written
    @basic_info_review_conflicts = {
      "name" =>
        ReviewConflict.new(risk_level: 100, category: "basic_info", item: "name", review_stage: 100, first_reviewer_id: current_dietitian.id),
      "cook_time" =>
      ReviewConflict.new(risk_level: 100, category: "basic_info", item: "cook_time", review_stage: 100, first_reviewer_id: current_dietitian.id),
      "prep_time" =>
      ReviewConflict.new(risk_level: 100, category: "basic_info", item: "prep_time", review_stage: 100, first_reviewer_id: current_dietitian.id),
      "serving_size" =>
      ReviewConflict.new(risk_level: 100, category: "basic_info", item: "serving_size", review_stage: 100, first_reviewer_id: current_dietitian.id),
      "difficulty" =>
      ReviewConflict.new(risk_level: 100, category: "basic_info", item: "difficulty", review_stage: 100, first_reviewer_id: current_dietitian.id)
    }
    @ingredient_review_conflicts = {}
    @recipe.ingredients_recipes.each do | ingredient |
      @ingredient_review_conflicts["ingredient-#{ingredient.id}"] = ReviewConflict.new(risk_level: 100, category: "ingredient", item: "ingredient-#{ingredient.id}", review_stage: 100, first_reviewer_id: current_dietitian.id)
    end
    @step_review_conflicts = {}
    @recipe.recipe_steps.each do | step |
      @step_review_conflicts["step-#{step.id}"] = ReviewConflict.new(risk_level: 100, category: "step", item: "step-#{step.id}", review_stage: 100, first_reviewer_id: current_dietitian.id)
    end
    @allergen_review_conflicts = {}
    @recipe.ingredients.each do | allergen |
      @allergen_review_conflicts["allergen-#{allergen.id}"] = ReviewConflict.new(risk_level: 100, category: "allergen", item: "allergen-#{allergen.id}", review_stage: 100, first_reviewer_id: current_dietitian.id)
    end
    @recipe_tag_review_conflicts = {}
    @recipe_tag_review_conflicts["health_group"] = ReviewConflict.new(risk_level: 1001, category: "health_group", item: "prep_time", review_stage: 100, first_reviewer_id: current_dietitian.id)
    @recipe_tag_review_conflicts["recipe_categories"] = ReviewConflict.new(risk_level: 100, category: "recipe_categories", review_stage: 100, first_reviewer_id: current_dietitian.id)
  end

  def edit

  end

  def create

  end

  # PATCH/PUT /articles/:id/quality_review/:id
  # PATCH/PUT /articles/:id/quality_review/:id.json
  def update

  end

  # POST articles/:id/quality_reviews
  def index

  end

  private

  # identifies whether the resource is an article or recipe before assigning instance variable @quality_reviewable as a recipe or article with the passed id returns the recipe or article object as quality_reviewable
  def load_quality_reviewable
    klass = [Article, Recipe].detect { |c| params["#{c.name.underscore}_id"]}
    @quality_reviewable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def quality_review_params
    params.require(:quality_review).permit(:passed, :dietitian_id, :recipe_id, :completed)
  end

  def set_quality_review
    @quality_review = QualityReview.find(params[:id])
  end


end