class RecipesController < ApplicationController
	include CharacteristicsHelper
	include StepsHelper
	include IngredientsHelper
  include IngredientsRecipesHelper
  include PatientGroupsHelper
  
  before_action :set_recipe, only: [:show, :edit, :destroy, :review_recipe]
  before_action :set_characteristic_forms, only: [:new, :edit]
  before_action :set_characteristic_display, only: [:show, :review_recipe]

  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = []
    #  This was written to get the last recipes from the database for chef review.  Filtered out the recipes that didn't have a dietitian or were written by certain authors, had more than 1 step and ingredient, and didn't have the word test in it
    # Recipe.first(803).each do |recipe| 
    #   if (recipe.dietitian) && (recipe.dietitian.email != "mrfinneran@gmail.com") && (recipe.dietitian.email != "mike@kindrdfood.com") && (recipe.dietitian.email != "david@kindrdfood.com") && (recipe.dietitian.email != "mrfinneran+rd@gmail.com") && (recipe.steps.count > 1) && (recipe.ingredients.count > 1)
    #     @recipes << recipe unless recipe.name.downcase.include? "test"
    #   end
    # end
    respond_to do |format|
      format.html
      format.csv { send_data @recipes.to_csv }
      format.xls
    end

  end

  ###notes
  # ## old dietitian dash a home controller or another controller
  # def dietitian_recipes_index
  #   if current_dietitian.has_role? "Marketing Reviewer"
  #     @all_completed_recipes = Recipe.where(completed: true).limit(250).order("created_at").reverse
  #   else
  #     @all_completed_recipes = Recipe.where(completed: true).limit(20).order("created_at").reverse
  #   end
  #   @recipes = Recipe.where(dietitian_id: current_dietitian.id, completed: true).order("created_at").reverse
  #   @incomplete_recipes = current_dietitian.incomplete_recipes
  #   @recipe_reviews_to_assign = []
  #   if current_dietitian.has_role? "Admin Dietitian"
  #     @recipes_need_original_review = Recipe.all_need_original_review
  #     @recipes_need_first_tier_review = Recipe.all_need_first_tier_review
  #     @recipes_need_second_tier_review = Recipe.all_need_second_tier_review
  #     @recipes_in_second_tier_review = Recipe.all_in_second_tier_review
  #     @recipes_in_first_tier_review = Recipe.all_in_first_tier_review
  #     @all_live_recipes = Recipe.all_live_recipes
  #     # @assign_review_conflicts_hash = ReviewConflict.assign_by_risk_level
  #     # @review_conflicts_in_review_hash = ReviewConflict.in_review_by_risk_level
  #     @resolved_quality_revews = QualityReview.where(resolved: true)
  #     # @resolved_review_conflicts = ReviewConflict.where(resolved: true)
  #     @test_recipes = Recipe.where(dietitian_id: 11).where(:created_at => Date.today.at_beginning_of_week.beginning_of_day..Date.tomorrow.end_of_day)
  #   end
  #   @incomplete_quality_reviews = current_dietitian.incomplete_quality_reviews
  #   # @incomplete_review_conflicts = ReviewConflict.assigned_to_dietitian(current_dietitian.id)
  # end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @recipe_id = params[:id]
    @recipe = Recipe.find(@recipe_id)
    @ingredients = @recipe.ordered_ingredients
    @steps_by_group = @recipe.steps_by_group
    @ingredients_tagged = @recipe.ingredients_tagged
    @ingredients_not_tagged = @recipe.ingredients_not_tagged
    @ingredients_allergens_hash = @recipe.fetch_ingredients_allergens_hash
    @health_groups_array = @recipe.fetch_health_groups_array
    @categories_array = @recipe.fetch_categories_array
    @marketing_items_by_group = @recipe.marketing_items_by_group
  end

  # GET /recipes/:id/review_recipe
  # GET /recipes/:id/review_recipe.json
  def review_recipe
    get_recipe_characteristics!
    @cook_times = @cook_times
    @prep_times = @prep_times
    @difficulties = @difficulties
    @serving_sizes = @serving_sizes
    get_units!
    @units = @units
    @ingredients = @recipe.ordered_ingredients
    @ingredients_count = @ingredients.count
    @steps_by_group = @recipe.steps_by_group
    @recipe_id = @recipe.id
    if @recipe.creation_stage < 7
      @recipe.creation_stage = 7
      @recipe.save
    end
    @all_ingredient_display_names = IngredientsRecipe.all_ingredient_display_names
    @all_ingredients = Ingredient.order(:name).map(&:name)
    @ingredients_tagged = @recipe.ingredients_tagged
    @ingredients_not_tagged = @recipe.ingredients_not_tagged
    @health_groups = @recipe.patient_groups
    @categories = @recipe.characteristics
    @marketing_items_by_group = @recipe.marketing_items_by_group
    # @allergies = @recipe.allergies
    # @diseases = @recipe.diseases
    # @intolerances = @recipe.intolerances

    # @marketing_items = @recipe.marketing_items
  end

  def complete_recipe
    @recipe = Recipe.find(params[:id])
    @recipe.completed = true
    @recipe.save
    redirect_to dietitian_recipes_path(current_dietitian)
  end


  # GET /recipes/new
  def new
    @recipe = Recipe.new
   # characteristics_helper
    get_recipe_characteristics!
    @cook_times = @cook_times
    @prep_times = @prep_times
    @difficulties = @difficulties
    @serving_sizes = @serving_sizes
    @all_recipe_names = Recipe.all_recipe_names
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    # assign dieititan to recipe
    @recipe.dietitian_id = current_dietitian.id
    @recipe.creation_stage = 1
    respond_to do |format|
      # if recipe saves correctly
      if @recipe.save
        format.html { redirect_to ingredients_recipes_path(recipe_id: @recipe.id), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
        @recipe_id = @recipe.id
        # set recipe_id sent from ingredients_recipe index form remote true
        format.js
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_patient_groups
    @recipe = Recipe.find(params[:id])
    if @recipe.creation_stage < 4
      @recipe.creation_stage = 4
      @recipe.save
    end
    get_patient_groups!
    @diseases = @diseases
    @intolerances = @intolerances
    @allergies = @allergies
    @diets = @diets
    @recipe_id = @recipe.id
    # for preview
    @health_groups = @recipe.patient_groups 
    @categories = @recipe.characteristics
    respond_to do |format|
      format.js {render "edit_patient_groups" and return}
      format.html {render "edit_patient_groups_page"}
    end
  end

  def update_patient_groups
    @recipe = Recipe.find(params["recipe_id"])
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to review_recipe_path(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
        @recipe_id = params["recipe_id"]
        format.js
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_recipe_categories
    @recipe_id = params[:id]
    @recipe = Recipe.find(@recipe_id)
    if @recipe.creation_stage < 5
      @recipe.creation_stage = 5
      @recipe.save
    end
    get_recipe_characteristics!
    @meals = @meals
    @cultures = @cultures
    @courses = @courses
    # for preview
    @health_groups = @recipe.patient_groups 
    @categories = @recipe.characteristics
    respond_to do |format|
      format.js {render "edit_recipe_categories" and return}
      format.html {render "edit_recipe_categories_page" and return}
    end
  end

  def update_recipe_categories
    @recipe = Recipe.find(params[:id])
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to review_recipe_path(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
        @recipe_id = params[:id]
        format.js
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /recipes/1/edit
  def edit
    get_recipe_characteristics!
    @cook_times = @cook_times
    @prep_times = @prep_times
    @difficulties = @difficulties
  end

  def edit_recipe_group
    @allergies = PatientGroup.safe_allergy_groups(@recipe.allergens)
    @diseases = PatientGroup.safe_disease_groups(@recipe.allergens)
    @intolerances = PatientGroup.safe_intolerance_groups(@recipe.allergens)
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUdT /recipes/1.json
  def update
    @recipe = Recipe.find(params[:id])
    respond_to do |format|
      if @recipe.update(recipe_params)
        ### notice how this redirects to review recipe
        format.html { redirect_to review_recipe_path(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def recipe_data
    if current_dietitian.has_role? "Admin Dietitian"
      @recipe_data_by_total = Recipe.data_by_total
      @recipe_data_by_dietitian = Recipe.data_by_dietitian
      @recipe_data_by_health_group = Recipe.data_by_health_group
    else
      redirect_to dietitian_recipes_path(current_dietitian)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    ### make as global helper method because also used in marketing_items_controller
    def set_characteristic_display

    end

    def set_characteristic_forms

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # need to change :image_url to :avatar when paperclip is working
    def recipe_params
      params.require(:recipe).permit(:image_url, :avatar, :name, :description, :dietitian_id, :cook_time, :prep_time, :serving_size, :difficulty, :complete, :live_recipe, :characteristic_ids => [], :patient_group_ids => [])
    end
end
