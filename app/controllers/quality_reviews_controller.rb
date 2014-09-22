class QualityReviewsController < ApplicationController
  before_filter :load_quality_reviewable
  before_filter :set_quality_review, only: [:update, :edit]

  def new
    @quality_review = QualityReview.new 
    @recipe_id = params[:recipe_id]
    @recipe = Recipe.find(@recipe_id)
    @ingredients = @recipe.ingredients_recipes
    @steps = @recipe.recipe_steps
    @health_groups = @recipe.patient_groups
    @categories = @recipe.characteristics
    @marketing_items_by_group = @recipe.marketing_items_by_group
    @ingredients_tagged = @recipe.ingredients_tagged
    @ingredients_not_tagged = @recipe.ingredients_not_tagged
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