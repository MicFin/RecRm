class ReviewConflictsController < ApplicationController
  include CharacteristicsHelper
  include IngredientsRecipesHelper
  before_filter :set_review_conflict, only: [:update, :edit]

  def new
  end

  def edit
    @quality_reviewable = Recipe.find(params[:recipe_id])
    @quality_review = QualityReview.find(params[:quality_review_id])
    @all_recipe_names = Recipe.all_recipe_names
    if @review_conflict.category == "Recipe Ingredient"
      @ingredient_changes_hash = @review_conflict.ingredient_changes_hash
    elsif @review_conflict.category == "Recipe Step"
      @step_changes_hash = @review_conflict.step_changes_hash
      @ingredients = @quality_reviewable.ordered_ingredients
    elsif @review_conflict.category == "Allergens"
      @allergens_changes_hash = @review_conflict.allergens_changes_hash
    else
    end
    @item = @review_conflict.item
    get_recipe_characteristics!
    @cook_times = @cook_times
    @prep_times = @prep_times
    @difficulties = @difficulties
    @serving_sizes = @serving_sizes
    get_units!
    @units = @units
    @all_ingredient_display_names = IngredientsRecipe.all_ingredient_display_names
    @all_ingredients = Ingredient.order(:name).map(&:name)
    # For ingredient allergens review conflict
    @top_allergens = Allergen.top_allergens.order(:name)
    @all_allergens = Allergen.common_allergens.map(&:name)
  end

  def create
    if params[:review_conflict][:category] == "Recipe Ingredient"
      params[:review_conflict][:first_suggestion] = "'#{params[:review_conflict][:first_suggestion][:amount]}' '#{params[:review_conflict][:first_suggestion][:unit]}' '#{params[:review_conflict][:first_suggestion][:display_name]}' '#{params[:review_conflict][:first_suggestion][:shopping_list_item]}' '#{params[:review_conflict][:first_suggestion][:options]}'"
    elsif params[:review_conflict][:category] == "Recipe Step"
      params[:review_conflict][:first_suggestion] = "#{params[:review_conflict][:first_suggestion][:step_group_name]} <3<* #{params[:review_conflict][:first_suggestion][:directions]} <3<* #{params[:review_conflict][:first_suggestion][:ingredients]}"
    elsif params[:review_conflict][:category] == "Allergens"
      ingredient = params[:review_conflict][:first_suggestion][:ingredient_name] 
      allergens = params[:review_conflict][:first_suggestion][:allergens]
      if params[:review_conflict][:first_suggestion][:common] == "true"
        common = "true"
      else
        common = "false"
      end
      params[:review_conflict][:first_suggestion] = ingredient + " <3<* " + common + " <3<* "
      allergens.each do |allergen|
        params[:review_conflict][:first_suggestion] += "#{allergen} <3<* "
      end
    end

    # create new review conflict
    @review_conflict = ReviewConflict.new(review_conflict_params)
    # add current dietitian as first reviewer
    @review_conflict.first_reviewer_id = current_dietitian.id
    # find quality review
    @quality_review = QualityReview.find(params[:quality_review_id])
    # connect review conflict to its quality review
    @review_conflict.quality_review_id = @quality_review.id
    # connect review conflict to its quality review
    @review_conflict.review_stage = 1
    # find qauality reviewable
    @quality_reviewable = Recipe.find(params[:recipe_id])
    respond_to do |format|
      if @review_conflict.save
        if ( params[:review_conflict][:category] == "Recipe Ingredient" )
          @ingredient_changes_hash = @review_conflict.ingredient_changes_hash
          @item = params[:review_conflict][:item]
        elsif (params[:review_conflict][:category] == "Recipe Step")
          @step_changes_hash = @review_conflict.step_changes_hash
          @item = params[:review_conflict][:item]
        elsif (params[:review_conflict][:category] == "Allergens")
          @allergens_changes_hash = @review_conflict.allergens_changes_hash
          @item = params[:review_conflict][:item]
        else
          @item = @review_conflict.item
        end
        @risk_level = @review_conflict.risk_level
        # add role of reviewer for this recipe and the dietitian assigned to do the review
        format.html { redirect_to dietitian_recipes_path(current_dietitian), notice: "Quality Review assigned."}
        format.json { render :show, status: :created, location: @review_conflict} 
        format.js
      else
        format.html { render :new }
        format.json { render json: @review_conflicte.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /articles/:id/review_conflict/:id
  # PATCH/PUT /articles/:id/review_conflict/:id.json
  def update
    if params[:review_conflict][:category] == "Recipe Ingredient"
      params[:review_conflict][:first_suggestion] = "'#{params[:review_conflict][:first_suggestion][:amount]}' '#{params[:review_conflict][:first_suggestion][:unit]}' '#{params[:review_conflict][:first_suggestion][:display_name]}' '#{params[:review_conflict][:first_suggestion][:shopping_list_item]}' '#{params[:review_conflict][:first_suggestion][:options]}'"
      params[:review_conflict][:original_entry]  = @review_conflict.original_entry
    elsif params[:review_conflict][:category] == "Recipe Step"
      params[:review_conflict][:first_suggestion] = "#{params[:review_conflict][:first_suggestion][:step_group_name]} <3<* #{params[:review_conflict][:first_suggestion][:directions]} <3<* #{params[:review_conflict][:first_suggestion][:ingredients]}"
      params[:review_conflict][:original_entry]  = @review_conflict.original_entry
    elsif params[:review_conflict][:category] == "Allergens"
      ingredient = params[:review_conflict][:first_suggestion][:ingredient_name] 
      allergens = params[:review_conflict][:first_suggestion][:allergens]
      binding.pry
      if params[:review_conflict][:first_suggestion][:common] == "true"
        common = "true"
      else
        common = "false"
      end
      params[:review_conflict][:first_suggestion] = ingredient + " <3<* " + common + " <3<* "
      allergens.each do |allergen|
        params[:review_conflict][:first_suggestion] += "#{allergen} <3<* "
      end
    end
    @review_conflict = ReviewConflict.new(review_conflict_params)
    # find qauality reviewable
    @quality_reviewable = Recipe.find(params[:recipe_id])
    # find wuality review
    @quality_review = QualityReview.find(params[:quality_review_id])
    respond_to do |format|
      if @review_conflict.save
        # add role of reviewer for this recipe and the dietitian assigned to do the review
        if ( @review_conflict.category == "Recipe Ingredient" )
          @ingredient_changes_hash = @review_conflict.ingredient_changes_hash
        elsif (@review_conflict.category == "Recipe Step")
          @step_changes_hash = @review_conflict.step_changes_hash
        elsif (@review_conflict.category == "Allergens")
          @allergens_changes_hash = @review_conflict.allergens_changes_hash
        end
        @risk_level = @review_conflict.risk_level
        @item = @review_conflict.item
        format.html { redirect_to reciquality_(current_dietitian), notice: "Quality Review assigned."}
        format.json { render :show, status: :created, location: @review_conflict} 
        format.js
      else
        format.html { render :new }
        format.json { render json: @review_conflicte.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # POST articles/:id/review_conflicts
  def index

  end

  private

  def review_conflict_params
    params.require(:review_conflict).permit(:risk_level, :category, :item, :first_suggestion, :second_suggestion, :third_suggestion, :issue, :resolved, :quality_review_id, :first_reviewer_id, :second_reviewer_id, :third_reviewer_id, :review_stage, :first_reviewer_notes, :second_reviewer_notes, :third_reviewer_notes, :original_entry)
  end

  def set_review_conflict
    @review_conflict = ReviewConflict.find(params[:id])
  end


end