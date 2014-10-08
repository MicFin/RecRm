class QualityReviewsController < ApplicationController
  include CharacteristicsHelper
  include IngredientsRecipesHelper
  before_filter :load_quality_reviewable
  before_filter :set_quality_review, only: [:start_review, :update, :edit]

  # POST articles/:id/quality_reviews
  def index

  end

  def start_review
    @recipe_id = params[:recipe_id]
    @quality_review_id = @quality_review.id
    @dietitians = Dietitian.all
    @recipe_id = params[:recipe_id]
    @recipe = Recipe.find(@recipe_id)
    # for basic info review
    get_recipe_characteristics!
    @cook_times = @cook_times
    @prep_times = @prep_times
    @difficulties = @difficulties
    @serving_sizes = @serving_sizes
    @all_recipe_names = Recipe.all_recipe_names
    # for ingredient review
    get_units!
    @units = @units
    @all_ingredient_display_names = IngredientsRecipe.all_ingredient_display_names
    @all_ingredients = Ingredient.order(:name).map(&:name)
    @ingredients = @recipe.ordered_ingredients
    # for steps review
    @steps_by_group = @recipe.steps_by_group
    # For allergen review
    @ingredients_tagged = @recipe.ingredients_tagged
    @top_allergens = Allergen.top_allergens.order(:name)
    @all_allergens = Allergen.common_allergens.map(&:name)
    @ingredients_allergens_hash = @recipe.fetch_ingredients_allergens_hash
    #
    @health_groups = @recipe.patient_groups
    #
    @categories = @recipe.characteristics
    #
    @marketing_items_by_group = @recipe.marketing_items_by_group
    # cen remove this and just use .new but need to change all forms
    @possible_review_conflicts = @recipe.fetch_possible_review_conflicts
  end

  def new
    @recipe_id = params[:recipe_id]
    @quality_review = @quality_reviewable.quality_reviews.new
    @dietitians = Dietitian.all
    @recipe_id = params[:recipe_id]
    @recipe = Recipe.find(@recipe_id)
    @ingredients = @recipe.ordered_ingredients
    @steps = @recipe.steps
    @health_groups = @recipe.patient_groups
    @categories = @recipe.characteristics
    @marketing_items_by_group = @recipe.marketing_items_by_group
    @ingredients_tagged = @recipe.ingredients_tagged
    @ingredients_not_tagged = @recipe.ingredients_not_tagged
  end

  def create
    @quality_review = @quality_reviewable.quality_reviews.new(quality_review_params)
    respond_to do |format|
      if @quality_review.save
        # add role of reviewer for this recipe and the dietitian assigned to do the review
        Dietitian.find(params[:quality_review][:dietitian_id]).add_role :reviewer, @quality_reviewable
        format.html { redirect_to dietitian_recipes_path(current_dietitian), notice: "Quality Review assigned."}
        format.json { render :show, status: :created, location: @quality_review} 
        format.js
      else
        format.html { render :new }
        format.json { render json: @quality_reviewable.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def edit

  end

  # PATCH/PUT /articles/:id/quality_review/:id
  # PATCH/PUT /articles/:id/quality_review/:id.json
  def update
    
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